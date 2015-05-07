# == Schema Information
#
# Table name: doctrines_roles
#
#  id          :integer          not null, primary key
#  role_id     :integer
#  doctrine_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class DoctrinesRole < ActiveRecord::Base
end
