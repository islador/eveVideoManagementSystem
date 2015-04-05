# == Schema Information
#
# Table name: chrRaces
#
#  raceID           :integer          not null, primary key
#  raceName         :text
#  description      :text
#  iconID           :integer
#  shortDescription :text
#

require 'rails_helper'

RSpec.describe ChrRace, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
