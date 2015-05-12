# == Schema Information
#
# Table name: ratings
#
#  id                 :integer          not null, primary key
#  name               :string
#  user_id            :integer
#  fleet_commander_id :integer
#  score              :integer          default("0")
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

require 'rails_helper'

RSpec.describe Rating, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
