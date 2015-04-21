# == Schema Information
#
# Table name: mission_groups
#
#  id           :integer          not null, primary key
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  name         :string
#  user_id      :integer
#  participants :text             default("{}"), is an Array
#

require 'rails_helper'

RSpec.describe MissionGroup, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
