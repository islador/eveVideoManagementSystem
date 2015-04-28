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

require 'rails_helper'

RSpec.describe FacWarSystem, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
