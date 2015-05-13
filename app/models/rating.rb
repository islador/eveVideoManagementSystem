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

class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :fleet_commander
end
