# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

no_operation = Operation.create(name: "No Operation", op_date: Date.today, op_prep_start: Time.now, op_departure: Time.now, op_completion: Time.now, ships: ["N/A"], doctrine: "N/A", fleet_commander: "N/A", voice_coms_server: "N/A", voice_coms_server_channel: "N/A", rally_point: "N/A", specialty_roles: ["N/A"])
