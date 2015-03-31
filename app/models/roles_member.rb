# == Schema Information
#
# Table name: roles_members
#
#  id         :integer          not null, primary key
#  role_id    :integer
#  member_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RolesMember < ActiveRecord::Base
end
