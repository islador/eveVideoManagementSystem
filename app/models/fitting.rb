# == Schema Information
#
# Table name: fittings
#
#  id                   :integer          not null, primary key
#  name                 :string
#  hull                 :string
#  race                 :string
#  fleet_role           :string
#  description          :text
#  progression          :string
#  progression_position :integer
#  eft_string           :string
#  ship_dna             :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  doctrine_id          :integer
#

class Fitting < ActiveRecord::Base
end
