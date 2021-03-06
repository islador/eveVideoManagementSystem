# == Schema Information
#
# Table name: members
#
#  id             :integer          not null, primary key
#  characterID    :integer
#  name           :string
#  startDateTime  :datetime
#  baseID         :integer
#  base           :string
#  title          :string
#  logonDateTime  :datetime
#  logoffDateTime :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  taken          :boolean
#  user_id        :integer
#

class Member < ActiveRecord::Base
  belongs_to :user

  has_many :roles
  has_and_belongs_to_many :roles

  validates :characterID, presence: true
  validates :name, presence: true
  validates :startDateTime, presence: true

end
