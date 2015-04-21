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

class MissionGroup < ActiveRecord::Base
  has_many :missions

  def accessible_to_user?(user)
    participants.include?(user.id.to_s)
  end

  def creatable_by_user?(user)
    # Allow the user to create a mission group if they're a member
    Member.where("user_id = ?", user.id).length >= 1
  end

  def editable_by_user?(user)
    # Allow the user to edit a mission group if they're the creator
    creator?(user)
  end

  # Check if the passed in user is the creator of the mission group
  def creator?(user)
    self.user_id == user_id
  end

  def participant?(user)
    self.participants.include?(user.id.to_s)
  end
end
