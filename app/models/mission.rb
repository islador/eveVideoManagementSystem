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
#

class Mission < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission_group

  validate :mission_text_cant_be_read_details

  def accessible_to_user?(user)
    # Check if the user is part of the mission group.
    self.mission_group.participant?(user)
  end

  def creatable_by_user?(user)
    # Allow the user to create a mission if they're a participant in the mission group
    self.mission_group.participant?(user)
  end

  def editable_by_user?(user)
    # Allow the user to edit a mission if they're the group or the mission's creator
    if self.mission_group.creator?(user) || self.user.id == current_user.id
      return true
    else
      false
    end
  end

  private
    def mission_text_cant_be_read_details
      if mission_text[3].blank? || mission_text[7].blank?
        errors.add(:mission_text, "Mission Text cannot be from read details.")
      end
    end
end
