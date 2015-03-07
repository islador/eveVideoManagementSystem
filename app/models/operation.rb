# == Schema Information
#
# Table name: operations
#
#  id                        :integer          not null, primary key
#  name                      :string
#  op_date                   :date
#  op_prep_start             :time
#  op_departure              :time
#  op_completion             :time
#  ships                     :text             default("{}"), is an Array
#  doctrine                  :string
#  fleet_commander           :string
#  voice_coms_server         :string
#  voice_coms_server_channel :string
#  rally_point               :string
#  specialty_roles           :text             default("{}"), is an Array
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Operation < ActiveRecord::Base

  has_many :videos

  def format_specialty_role_list
    specialty_role_list = ""
    specialty_roles.each do | specialty_role |
      specialty_role_list = specialty_role_list + "#{specialty_role}, "
    end
    specialty_role_list.chop.chop
  end

  def format_ship_list
    ship_list = ""
    ships.each do | ship|
      ship_list = ship_list + "#{ship} >"
    end
    ship_list.chop.chop
  end

  def pst(time)
    Time.at(time).in_time_zone("Pacific Time (US & Canada)")
  end

  def cst(time)
    Time.at(time).in_time_zone("Central Time (US & Canada)")

  end

  def est(time)
    Time.at(time).in_time_zone("Eastern Time (US & Canada)")
  end
end
