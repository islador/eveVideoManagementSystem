# == Schema Information
#
# Table name: fleet_commanders
#
#  id                           :integer          not null, primary key
#  overall_rating               :integer          default("0")
#  fun_rating                   :integer          default("0")
#  communication_clarity_rating :integer          default("0")
#  noob_friendly_rating         :integer          default("0")
#  target_selection_rating      :integer          default("0")
#  friendly_rating              :integer          default("0")
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

require 'rails_helper'

RSpec.describe FleetCommander, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
