# == Schema Information
#
# Table name: videos
#
#  id           :integer          not null, primary key
#  name         :string
#  filmed_on    :date
#  operation_id :integer
#  s3_url       :string
#  kind         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Video < ActiveRecord::Base
  belongs_to :operation
end
