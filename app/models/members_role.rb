# == Schema Information
#
# Table name: members_roles
#
#  id         :integer          not null, primary key
#  member_id  :integer
#  role_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MembersRole < ActiveRecord::Base
end
