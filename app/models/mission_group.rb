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
  has_many :missions, dependent: :destroy
  belongs_to :user

  def accessible_to_user?(user)
    self.participant?(user)
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
    self.user_id == user.id
  end

  # Participants is an array of member IDs that are used to determine who can and can't join
  # regardless of whether the member has been claimed or not.
  def participant?(user)
    member_id = Member.where("name = ?", user.main_character_name)[0].id
    self.participants.include?(member_id.to_s)
  end
end
