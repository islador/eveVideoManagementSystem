# == Schema Information
#
# Table name: doctrines
#
#  id                  :integer          not null, primary key
#  name                :string
#  short_description   :string
#  long_description    :text
#  access_by_hierarchy :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Doctrine < ActiveRecord::Base

  has_many :roles
  has_and_belongs_to_many :roles
end
