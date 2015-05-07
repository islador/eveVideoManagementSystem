# == Schema Information
#
# Table name: invTypes
#
#  typeID              :integer          not null, primary key
#  groupID             :integer
#  typeName            :text
#  description         :text
#  mass                :float
#  volume              :float
#  capacity            :float
#  portionSize         :integer
#  raceID              :integer
#  basePrice           :decimal(19, 4)
#  published           :boolean
#  marketGroupID       :integer
#  chanceOfDuplicating :float
#

require 'rails_helper'

RSpec.describe InvType, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
