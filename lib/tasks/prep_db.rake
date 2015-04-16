require 'rake'
namespace :prep_db do

  desc "Add the default roles to the database."
  task add_base_roles: :environment do
    Role.create(name: "Unknown", description: "Unknown", hierarchy_ranking: 0)
    Role.create(name: "Blue +5", description: "A blue with +5 standings", hierarchy_ranking: 1)
    Role.create(name: "Blue +10", description: "A blue with +10 standings", hierarchy_ranking: 2)
    Role.create(name: "Militia Member", description: "A member of the friendly militia", hierarchy_ranking: 3)
    Role.create(name: "Alliance Member", description: "A member of the alliance", hierarchy_ranking: 4)
    Role.create(name: "Corp Member", description: "A member of the corporation", hierarchy_ranking: 5)
    Role.create(name: "Corp Director", description: "A director in the corporation", hierarchy_ranking: 6)
    Role.create(name: "Corp CEO", description: "CEO of the corporation", hierarchy_ranking: 7)
  end

  desc "Load the WarZoneCombatSystem table."
  task populate_war_zone_combat_system: :environment do
    csv_text = File.read("#{Rails.root.join("db","sde_exports","warCombatZoneSystems.csv")}")

    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      WarCombatZoneSystem.create(row.to_hash)
    end
  end

  desc "Load the SolarSystem's table with known systems of interest."
  task populate_solar_systems: :environment do
    csv_text = File.read("#{Rails.root.join("db","sde_exports","stateProtectorateMissionSystems.csv")}")

    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      SolarSystem.create(row.to_hash)
    end
  end
end
