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

require 'rails_helper'

RSpec.describe FleetCommander, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
