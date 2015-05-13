# == Schema Information
#
# Table name: fleet_commanders
#
#  id                           :integer          not null, primary key
#  overall_rating               :integer          default("0")
#  fun_rating                   :integer          default("0")
#  communication_clarity_rating :integer          default("0")
#  noob_friendly_rating         :integer          default("0")
#  target_selection_rating      :integer          default("0")
#  friendly_rating              :integer          default("0")
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  name                         :string
#  language                     :string
#

class FleetCommander < ActiveRecord::Base
  has_many :ratings
  # Create FC: https://gist.github.com/kyletcarlson/7911188
  # Headers: http://stackoverflow.com/questions/7478841/how-to-specify-http-request-header-in-open-uri
end
