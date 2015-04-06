class FittingsController < ApplicationController
  def index
    @doctrine = Doctrine.find(params[:doctrine_id])
    @fittings = Fitting.where(doctrine_id: params[:doctrine_id])
    authorize @fittings[0]
  end

  def create
    @fitting = Fitting.new(create_fitting_params)
    authorize @fitting
    # Split the EFT String apart line by line
    eft_string = params[:eft_string]
    eft_string_components = eft_string.split("\n")

    # Extract the hull and name data from the first line
    clean_info_bracket = eft_string_components[0].chomp
    info_bracket = clean_info_bracket.slice(1..clean_info_bracket.length-2).split(", ")
    @fitting.hull = info_bracket[0]
    @fitting.name = info_bracket[1]
    @fitting.race = ChrRace.where(raceID: InvType.where("\"typeName\" = ?", "Drake").pluck("\"raceID\""))[0].raceName
    @fitting.ship_dna = create_ship_dna(@fitting)
    if @fitting.save
      doctrine = @fitting.doctrine
      redirect_to doctrine_path(@fitting.doctrine)
    else
      @doctrine = Doctrine.find(params[:doctrine_id])
      render 'new'
    end
  end

  def new
    @doctrine = Doctrine.find(params[:doctrine_id])
    @fitting = Fitting.new(doctrine_id: @doctrine.id)
    authorize @fitting
  end

  def edit
    @fitting = Fitting.find(params[:id])
    authorize @fitting
  end

  def show
    @fitting = Fitting.find(params[:id])
    authorize @fitting
  end

  def update
    @fitting = Fitting.find(params[:id])
    authorize @fitting

    if @fitting.update_attributes(create_fitting_params)
      if @fitting.save
        redirect_to doctrine_fittings_path(@fitting)
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    @fitting = Fitting.find(params[:id])
    authorize @fitting

    @fitting.destroy
    redirect_to doctrine_fittings_path(params[:doctrine_id])
  end

  private
    def create_fitting_params
      params.permit(:name, :hull, :race, :fleet_role, :description, :progression, :progression_position, :eft_string, :doctrine_id)
    end

    def create_ship_dna(fitting)
      # Split the EFT String on each new line character
      eft_string_split = fitting.eft_string.split("\n")
      # Remove the info bracket as it isn't needed.
      eft_string_split.delete_at(0)
      # Iterate over each line
      # dna lows, meds, highs, subs, rigs, drones/charges?
      dna = [{},{},{},{},{},{}]
      dna_counter = 0
      eft_string_split.each do |line|
        # Strip the trailing newline character
        line = line.chomp
        puts line
        # If the line is blank
        if line.blank?
          # Increment the dna counter
          dna_counter+=1
          if dna_counter == 3
            unless ["Proteus","Loki","Legion","Tengu"].include?(fitting.hull)
              dna_counter += 1
            end
          end

          if dna_counter == 6
            break
          end
        else
          # Check the item for charges
          ammo_check_split = line.split(", ")
          if ammo_check_split.length > 1
            # Add the charge to the charges hash
            if dna[5]["#{ammo_check_split[1]}"]
              dna[5]["#{ammo_check_split[1]}"] +=1
            else
              dna[5].store("#{ammo_check_split[1]}", 1)
            end
            # Remove the charge from the line
            line = ammo_check_split[0].chomp(",")
          end
          # Check if the item already exists in the dna_hash
          if dna[dna_counter]["#{line}"]
            # Increment the count of that item
            dna[dna_counter]["#{line}"]+=1
          else
            line_value = 1
            # If the line ends in 'x5', etc, ensure that value is captured and passed into the hash
            match_data = /x[0-9]+$/.match(line)
            if match_data
              matched_string = match_data.to_s
              # Trim the value off the string
              line = line.slice(0,(line.length - matched_string.length)-1)
              # Update the line_value value
              line_value = /[0-9]+/.match(matched_string).to_s.to_i
            end
            # Add the item to the list.
            dna[dna_counter].store("#{line}", line_value)
          end
        end
      end
      puts dna
      # Convert the DNA hash to a DNA string with type IDs
      dna_string = ""
      # Retrieve ship typeID
      ship_typeID = InvType.where("\"typeName\" = ?", fitting.hull).pluck(:typeID)[0]
      dna_string = dna_string + "#{ship_typeID}:"
      # Check for subsystems
      unless dna[3].empty?
        # Iterate over the hash
        dna[3].each do |key, value|
          # Retrieve the typeID for each key
          typeID = InvType.where("\"typeName\" = ?", key).pluck(:typeID)[0]
          # Append the typeID & quantity to the dna string
          dna_string = dna_string + "#{typeID};#{value}:"
        end
      end
      # Iterate over the high slots hash
      dna[2].each do |key, value|
        # Retrieve the typeID for each key
        typeID = InvType.where("\"typeName\" = ?", key).pluck(:typeID)[0]
        # Append the typeID & quantity to the dna string
        dna_string = dna_string + "#{typeID};#{value}:"
      end

      # Iterate over the med slots hash
      dna[1].each do |key, value|
        # Retrieve the typeID for each key
        typeID = InvType.where("\"typeName\" = ?", key).pluck(:typeID)[0]
        # Append the typeID & quantity to the dna string
        dna_string = dna_string + "#{typeID};#{value}:"
      end

      # Iterate over the low slots hash
      dna[0].each do |key, value|
        # Retrieve the typeID for each key
        typeID = InvType.where("\"typeName\" = ?", key).pluck(:typeID)[0]
        # Append the typeID & quantity to the dna string
        dna_string = dna_string + "#{typeID};#{value}:"
      end

      # Iterate over the rigs hash
      dna[4].each do |key, value|
        # Retrieve the typeID for each key
        typeID = InvType.where("\"typeName\" = ?", key).pluck(:typeID)[0]
        # Append the typeID & quantity to the dna string
        dna_string = dna_string + "#{typeID};#{value}:"
      end

      # Iterate over the charges hash
      dna[5].each do |key, value|
        # Retrieve the typeID for each key
        typeID = InvType.where("\"typeName\" = ?", key).pluck(:typeID)[0]
        # Append the typeID & quantity to the dna string
        dna_string = dna_string + "#{typeID};#{value}:"
      end
      dna_string = dna_string + ":"

      return dna_string
    end
end
