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

require 'rails_helper'

RSpec.describe Month, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
