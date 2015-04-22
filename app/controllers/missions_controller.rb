class MissionsController < ApplicationController
  def show
    @mission = Mission.find(params[:id])
    authorize @mission
  end

  def new
    @mission_group_id = params[:mission_group_id]
    @mission = Mission.new(mission_group_id: @mission_group_id)
    authorize @mission
  end

  def create
    # Cut the mission description into a tab delimited array
    mission_text = params["Mission Description"].split("\t")

    @mission = Mission.new(mission_text: mission_text, mission_group_id: params[:mission_group_id])
    authorize @mission
    if @mission.valid?
      params.permit(:mission_group_id)
      @mission.user_id = current_user.id
      @mission.name = @mission.mission_text[0].split("Objectives")[0].chomp(" ")
      @mission.loyalty_points = @mission.mission_text[7].split("Loyalty")[0].to_i

      # Populate the mission's state booleans
      @mission.incomplete = true
      @mission.complete = false
      @mission.obstructed = false

      #@mission.mission_group_id = params[:mission_group_id]
      # Extract the mission system name from the mission_text
      mission_system = @mission.mission_text[3].split(" ")[0]
      mission_system_name = mission_system.slice(4, mission_system.length)
      # Retrieve and store the solarSystemID
      @mission.fac_war_system_id = FacWarSystem.where(solarSystemName: mission_system_name).pluck(:solarSystemID)[0]

      # Save and redirect
      @mission.save
      redirect_to mission_group_missions_path(params[:mission_group_id])
    else
      flash[:alert] = "Missions cannot be indexed unless the text being submitted is from the offer or accepted stage. You submitted a copy of the read details stage."
      render 'new'
    end
  end

  def index
    @mission_group_id = params[:mission_group_id]
    @mission_group = MissionGroup.find(params[:mission_group_id])
    @missions = Mission.where(mission_group_id: params[:mission_group_id])

    # Authorize the user to view the index.
    if @missions.empty?
      authorize @mission_group.missions.new()
    else
      authorize @missions.first
    end

    @total_potential_loyalty_points = @missions.where("incomplete = ?", true).sum(:loyalty_points)
    @total_earned_loyalty_points = @missions.where("complete = ?", true).sum(:loyalty_points)
    @total_obstructed_loyalty_points = @missions.where("obstructed = ?", true).sum(:loyalty_points)

    unique_user_count = @missions.pluck(:user_id).count
    if @total_potential_loyalty_points > 0
      @potential_loyalty_points_per_user = @total_potential_loyalty_points / unique_user_count
    else
      @potential_loyalty_points_per_user = 0
    end

    if @total_earned_loyalty_points > 0
      @earned_loyalty_points_per_user = @total_earned_loyalty_points / unique_user_count
    else
      @earned_loyalty_points_per_user = 0
    end

    if @total_obstructed_loyalty_points > 0
      @obstructed_loyalty_points_per_user = @total_obstructed_loyalty_points / unique_user_count
    else
      @obstructed_loyalty_points_per_user = 0
    end

    # Build a list of all the unique mission destinations for use in linking to dotlan
    @mission_system_list = ""
    uniq_mission_system_ids = @missions.where("incomplete = ? AND obstructed = ?", true, false).pluck(:fac_war_system_id).uniq
    system_names = FacWarSystem.where(solarSystemID: uniq_mission_system_ids).pluck(:solarSystemName)
    system_names.each do |system|
      @mission_system_list = @mission_system_list + "#{system},"
    end
    @mission_system_list.chomp!(",")

    # Build a list of all the unique obstructed mission destinations for use in linking to dotlan
    @obstructed_system_list = ""
    uniq_obstructed_system_ids = @missions.where("obstructed = ?", true).pluck(:fac_war_system_id).uniq
    system_names = FacWarSystem.where(solarSystemID: uniq_obstructed_system_ids).pluck(:solarSystemName)
    system_names.each do |system|
      @obstructed_system_list = @obstructed_system_list + "#{system},"
    end
    @obstructed_system_list.chomp!(",")

    # Build a hash of all unique systems & ids to display the system name from
    @system_names_hash = {}
    systems = FacWarSystem.where(solarSystemID: @missions.pluck(:fac_war_system_id).uniq).pluck(:solarSystemID, :solarSystemName)
    systems.each do |system|
      @system_names_hash.store(system[0], system[1])
    end
  end

  def mark_obstructed
    mission = Mission.find(params[:mission_id])
    authorize mission
    mission.obstructed = true
    mission.complete = false
    mission.incomplete = false
    mission.save
    redirect_to mission_group_missions_path(mission.mission_group_id)
  end

  def mark_complete
    mission = Mission.find(params[:mission_id])
    authorize mission
    mission.obstructed = false
    mission.complete = true
    mission.incomplete = false
    mission.save
    redirect_to mission_group_missions_path(mission.mission_group_id)
  end

  def mark_incomplete
    mission = Mission.find(params[:mission_id])
    authorize mission
    mission.obstructed = false
    mission.complete = false
    mission.incomplete = true
    mission.save
    redirect_to mission_group_missions_path(mission.mission_group_id)
  end

  def destroy
    @mission = Mission.find(params[:id])
    authorize @mission
    @mission.destroy
  end

  def accessible_agents
    @accessible_systems = []
    # Retrieve all state protectorate systems from the database
    systems = SolarSystem.where(missions: "State Protectorate")

    # Push all highsec state protectorate system names into the accessible_systems list
    @accessible_systems << systems.where("security > 0.45").pluck("solarSystemName")

    # Push all accessible lowsec state protectorate system names into the accessible_systems list
    @accessible_systems << FacWarSystem.where(solarSystemID: systems.pluck("solarSystemID")).where("\"occupyingFactionID\" = 500001 OR \"occupyingFactionID\" = 0 AND \"owningFactionID\" = 500001").pluck("solarSystemName")
    @accessible_systems.flatten!
    # Format the list for easy linking
    @accessible_system_list = ""
    @accessible_systems.each do |system|
      @accessible_system_list = @accessible_system_list + "#{system},"
    end
    @accessible_system_list.chomp!(",")
  end

  private
    #def create_mission_params
    #  params.permit("Mission Description")
    #end
end
