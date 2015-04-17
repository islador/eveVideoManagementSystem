# == Schema Information
#
# Table name: mission_groups
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  name       :string
#

class MissionGroup < ActiveRecord::Base
  has_many :missions
end
