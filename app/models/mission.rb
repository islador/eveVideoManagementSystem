# == Schema Information
#
# Table name: missions
#
#  id                :integer          not null, primary key
#  offered_text      :text
#  accepted_text     :text
#  read_details_text :text
#  name              :string
#  user_id           :integer
#  fac_war_system_id :integer
#  loyalty_points    :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Mission < ActiveRecord::Base
end
