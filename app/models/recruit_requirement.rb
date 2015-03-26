# == Schema Information
#
# Table name: recruit_requirements
#
#  id         :integer          not null, primary key
#  detail     :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecruitRequirement < ActiveRecord::Base
  validates :detail, presence: true
end
