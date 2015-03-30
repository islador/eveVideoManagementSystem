# == Schema Information
#
# Table name: roles
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  hierarchy_ranking :integer
#  user_id           :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Role < ActiveRecord::Base

  validates :name, presence: true
  validates :description, presence: true
  validates :hierarchy_ranking, presence: true
end
