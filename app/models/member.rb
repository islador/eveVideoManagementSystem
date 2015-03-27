# == Schema Information
#
# Table name: members
#
#  id             :integer          not null, primary key
#  characterID    :integer
#  name           :string
#  startDateTime  :datetime
#  baseID         :integer
#  base           :string
#  title          :string
#  logonDateTime  :datetime
#  logoffDateTime :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Member < ActiveRecord::Base
end
