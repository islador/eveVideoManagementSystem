# == Schema Information
#
# Table name: missions
#
#  id                :integer          not null, primary key
#  name              :string
#  user_id           :integer
#  fac_war_system_id :integer
#  loyalty_points    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  mission_text      :text             default("{}"), is an Array
#  mission_group_id  :integer
#  incomplete        :boolean
#  complete          :boolean
#  obstructed        :boolean
#

require 'rails_helper'

RSpec.describe Mission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
