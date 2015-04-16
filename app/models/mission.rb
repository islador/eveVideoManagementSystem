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
#

class Mission < ActiveRecord::Base
  belongs_to :user

  validate :mission_text_cant_be_read_details

  private
    def mission_text_cant_be_read_details
      if mission_text[3].blank? || mission_text[7].blank?
        errors.add(:mission_text, "Mission Text cannot be from read details.")
      end
    end
end
