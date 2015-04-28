class FacWarSystemsController < ApplicationController
  def index
    authorize self
    @fac_war_systems = FacWarSystem.all
  end

  def refresh_fac_war_systems
    # This should be sent out to a sidekiq worker when infrastructure permits.
    authorize self

    begin
      # Query the API for fac war systems
      eve_api = Eve::API.new(key_id: "4233755", v_code: "1fu1tvYX38Ub5GE6K6W7zc1DWAd5UMpNzebSX32ZSapWmRBOMk00duZKDSDhLaKf")
      fac_war_systems = eve_api.map.fac_war_systems

      # Remove all existing fac war systems
      # Note: It may be worth retaining this data in the future, but for now
      # that would be ancillary
      FacWarSystem.destroy_all

      # Repopulate the FacWarSystem table with the results from the api query
      fac_war_systems.rowsets[0].each do |row|
        FacWarSystem.create(
          solarSystemID: row.solar_system_id,
          solarSystemName: row.solar_system_name,
          occupyingFactionID: row.occupying_faction_id,
          owningFactionID: row.owning_faction_id,
          occupyingFactionName: row.occupying_faction_name,
          owningFactionName: row.owning_faction_name,
          contested: row.contested,
          victoryPoints: row.victory_points,
          victoryPointThreshold: row.victory_point_threshold
          )
      end
      flash[:notice] = "Fac War Systems Pull Successful"
      redirect_to fac_war_systems_path
    rescue Eve::Errors::AuthenticationError => e
      flash[:alert] = "Fac War Systems Pull Failed, check logs"
      redirect_to fac_war_systems_path
    end
  end
end
