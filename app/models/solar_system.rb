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

class SolarSystem < ActiveRecord::Base
end
