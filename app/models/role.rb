# == Schema Information
#
# Table name: roles
#
#  id                :integer          not null, primary key
#  name              :string
#  description       :text
#  hierarchy_ranking :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Role < ActiveRecord::Base

  validates :name, presence: true
  validates :description, presence: true
  validates :hierarchy_ranking, presence: true

  #has_many_and_belongs_to_many :users
end
