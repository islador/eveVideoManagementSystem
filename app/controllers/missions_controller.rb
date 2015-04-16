class MissionsController < ApplicationController
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
end
