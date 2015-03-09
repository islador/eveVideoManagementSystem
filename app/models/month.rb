# == Schema Information
#
# Table name: months
#
#  id         :integer          not null, primary key
#  year_id    :integer
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Month < ActiveRecord::Base
  belongs_to :year
  has_many :operations
end
