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

require 'rails_helper'

RSpec.describe Mission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
