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

require 'rails_helper'

RSpec.describe Doctrine, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
