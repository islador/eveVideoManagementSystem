class DoctrinesController < ApplicationController
  def index
    # This is messy, and can probably be done easier.
    @doctrines = Doctrine.where(id: DoctrinesRole.where(role_id: current_user.roles.pluck(:id)).pluck(:doctrine_id))
  end

  def new
    @doctrine = Doctrine.new
    authorize @doctrine

    @roles = current_user.less_or_equal_roles
  end

  def create
    @doctrine = Doctrine.new(create_doctrine_params)
    authorize @doctrine
    if @doctrine.save
      # Batch insert all the roles the doctrine should have into the database
      doctrines_roles = []
      params[:roles].each do |role_id|
        doctrines_roles << {doctrine_id: @doctrine.id, role_id: role_id}
      end
      DoctrinesRole.create(doctrines_roles)

      redirect_to doctrines_path
    else
      @roles = current_user.less_or_equal_roles
      render 'new'
    end
  end

  def show
    @doctrine = Doctrine.find(params[:id])
    authorize @doctrine

    fittings = @doctrine.fittings
    # @fittings_hash contains the organized doctrine for display to the user.
    @fittings_hash = {}
    # Iterater over each fit
    fittings.each do |fit|
      # if there is already a key in the hash for the race
      if @fittings_hash["#{fit.race}"].present?
        # Check if the fit's progression exists as well
        if @fittings_hash["#{fit.race}"]["#{fit.progression}"].present?
          # If it it does, add the fit to the progression
          @fittings.hash["#{fit.race}"]["#{fit.progression}"] << fit
          # and sort the fit array by progression_position
          @fittings.hash["#{fit.race}"]["#{fit.progression}"].sort_by! {|a,b| a.progression_position < b.progression_position}
        # Otherwise,
        else
          # store a new key value pair containing the progression & the fit into the race hash
          @fittings_hash["#{fit.race}"].store("#{fit.progression}", [fit])
        end
      # Otherwise,
      else
        # Store the race in the hash, with a hash as it's value.
        # The child hash should have the fit's progression as its key and the fit should
        # be in an array as that key's value
        @fittings_hash.store("#{fit.race}", {"#{fit.progression}" => [fit]})
      end
    end
  end

  def edit
    @doctrine = Doctrine.find(params[:id])
    authorize @doctrine
    # Edit should only be available to the doctrine owner? Think on this
  end

  def update
    @doctrine = Doctrine.find(params[:id])
    authorize @doctrine

    if @doctrine.update_attributes(create_doctrine_params)
      if @doctrine.save
        # Update roles if necessary, to determine this:
        # Retrieve the new role and old role ids
        new_role_ids = params[:roles]
        old_role_ids = @doctrine.roles.pluck(:id)
        # Determine the overlap between new and old
        intersection = new_role_ids & old_role_ids
        # Check if any of the roles have changed
        unless intersection.length == new_role_ids.length && intersection.length == old_role_ids.length
          # If they have;
          # Remove any overlap from both arrays
          new_role_ids.delete(intersection)
          old_role_ids.delete(intersection)
          # Delete remaining old roles
          DoctrinesRole.where(doctrine_id: @doctrine.id, role_id: [old_role_ids])
          # Create remaining new roles
          create_new_roles = []
          new_role_ids.each do |role_id|
            create_new_roles << {doctrine_id: @doctrine.id, role_id: role_id}
          end
          DoctrinesRole.create(create_new_roles)
        end
        redirect_to doctrines_path
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    @doctrine = Doctrine.find(params[:id])
    authorize @doctrine
  end

  private
    def create_doctrine_params
      params.permit(:name, :abbreviation, :short_description, :long_description, :access_by_hierarchy)
    end
end
