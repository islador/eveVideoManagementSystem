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
  end
end
