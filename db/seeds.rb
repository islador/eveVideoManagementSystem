# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed the DB with a single no-operation to represent solo or non-op PVP.
no_operation = Operation.create(name: "No Operation", op_date: Date.today, op_prep_start: Time.now, op_departure: Time.now, op_completion: Time.now, ships: ["N/A"], doctrine: "N/A", fleet_commander: "N/A", voice_coms_server: "N/A", voice_coms_server_channel: "N/A", rally_point: "N/A", specialty_roles: ["N/A"])

# Seed the db with the base roles.
Role.create(name: "Unknown", description: "Unknown", hierarchy_ranking: 0)
Role.create(name: "Blue +5", description: "A blue with +5 standings", hierarchy_ranking: 1)
Role.create(name: "Blue +10", description: "A blue with +10 standings", hierarchy_ranking: 2)
Role.create(name: "Militia Member", description: "A member of the friendly militia", hierarchy_ranking: 3)
Role.create(name: "Alliance Member", description: "A member of the alliance", hierarchy_ranking: 4)
Role.create(name: "Corp Member", description: "A member of the corporation", hierarchy_ranking: 5)
Role.create(name: "Corp Director", description: "A director in the corporation", hierarchy_ranking: 6)
ceo = Role.create(name: "Corp CEO", description: "CEO of the corporation", hierarchy_ranking: 7)

islador = Member.create(name: "islador", characterID: 601261354)

MembersRole.create(member_id: islador.id, role_id: ceo.id)
