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

class ChrRace < ActiveRecord::Base
  self.table_name = "chrRaces"
end
