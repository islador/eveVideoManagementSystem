# == Schema Information
#
# Table name: operations
#
#  id                        :integer          not null, primary key
#  name                      :string
#  eve_date                  :date
#  ships                     :text             default("{}"), is an Array
#  doctrine                  :string
#  fleet_commander           :string
#  eve_time                  :datetime
#  voice_coms_server         :string
#  voice_coms_server_channel :string
#  rally_point               :string
#  specialty_roles           :text             default("{}"), is an Array
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

require 'rails_helper'

RSpec.describe Operation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
