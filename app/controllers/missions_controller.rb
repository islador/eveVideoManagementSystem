class MissionsController < ApplicationController
  def show
    @mission = Mission.find(params[:id])
  end

  def new
    @mission_group_id = params[:mission_group_id]
    @mission = Mission.new()
  end

  def create
    # Cut the mission description into a tab delimited array
    mission_text = params["Mission Description"].split("\t")

    @mission = Mission.new(mission_text: mission_text)
    if @mission.valid?
      params.permit(:mission_group_id)
      @mission.user_id = current_user.id
      @mission.name = @mission.mission_text[0].split("Objectives")[0].chomp(" ")
      @mission.loyalty_points = @mission.mission_text[7].split("Loyalty")[0].to_i
      @mission.mission_group_id = params[:mission_group_id]
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

    @total_loyalty_points = @missions.sum(:loyalty_points)
    if @total_loyalty_points > 0
      @loyalty_points_per_user = @total_loyalty_points / @missions.pluck(:user_id).uniq.count
    else
      @loyalty_points_per_user = 0
    end

    # Build a list of all the unique mission destinations for use in linking to dotlan
    @mission_system_list = ""
    uniq_mission_system_ids = @missions.pluck(:fac_war_system_id).uniq
    system_names = FacWarSystem.where(solarSystemID: uniq_mission_system_ids).pluck(:solarSystemName)
    system_names.each do |system|
      @mission_system_list = @mission_system_list + "#{system},"
    end
    @mission_system_list.chomp!(",")
  end

  def destroy
    Mission.find(params[:id]).destroy
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
