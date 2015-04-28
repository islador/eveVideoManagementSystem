# == Schema Information
#
# Table name: solar_systems
#
#  id              :integer          not null, primary key
#  solarSystemName :string
#  solarSystemID   :integer
#  security        :float
#  missions        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe SolarSystem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
