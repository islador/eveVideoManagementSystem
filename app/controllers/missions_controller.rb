class MissionsController < ApplicationController
  def show
    @mission = Mission.find(params[:id])
  end

  def new
    @mission = Mission.new()
  end

  def create
    # Cut the mission description into a tab delimited array
    mission_text = params["Mission Description"].split("\t")

    @mission = Mission.new(mission_text: mission_text)
    if @mission.valid?
      @mission.user_id = current_user.id
      @mission.name = @mission.mission_text[0].split("Objectives")[0].chomp(" ")
      @mission.loyalty_points = @mission.mission_text[7].split("Loyalty")[0].to_i

      # Extract the mission system name from the mission_text
      mission_system = @mission.mission_text[3].split(" ")[0]
      mission_system_name = mission_system.slice(4, mission_system.length)
      # Retrieve and store the solarSystemID
      @mission.fac_war_system_id = FacWarSystem.where(solarSystemName: mission_system_name).pluck(:solarSystemID)[0]

      # Save and redirect
      @mission.save
      redirect_to missions_path
    else
      flash[:alert] = "Missions cannot be indexed unless the text being submitted is from the offer or accepted stage. You submitted a copy of the read details stage."
      render 'new'
    end
  end

  def index
    @missions = Mission.all

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
