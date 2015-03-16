# == Schema Information
#
# Table name: recruit_contacts
#
#  id                :integer          not null, primary key
#  name              :string
#  contacted_by      :string
#  conversation_type :string
#  timezone          :string
#  conclusion        :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe RecruitContact, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
