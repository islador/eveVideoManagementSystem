# == Schema Information
#
# Table name: fleet_commanders
#
#  id                           :integer          not null, primary key
#  overall_rating               :integer
#  fun_rating                   :integer
#  communication_clarity_rating :integer
#  noob_friendly_rating         :integer
#  target_selection_rating      :integer
#  friendly_rating              :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

class FleetCommander < ActiveRecord::Base
end
