# == Schema Information
#
# Table name: fac_war_systems
#
#  id                    :integer          not null, primary key
#  solarSystemID         :integer
#  solarSystemName       :string
#  occupyingFactionID    :integer
#  owningFactionID       :integer
#  occupyingFactionName  :string
#  owningFactionName     :string
#  contested             :boolean
#  victoryPoints         :integer
#  victoryPointThreshold :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#

class FacWarSystem < ActiveRecord::Base
end
