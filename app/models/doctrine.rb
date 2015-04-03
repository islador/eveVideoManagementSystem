# == Schema Information
#
# Table name: doctrines
#
#  id                  :integer          not null, primary key
#  name                :string
#  short_description   :string
#  long_description    :text
#  access_by_hierarchy :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  abbreviation        :string
#

class Doctrine < ActiveRecord::Base

  has_many :roles
  has_and_belongs_to_many :roles

  validates :name, presence: true
  validates :short_description, presence: true
  validates :abbreviation, presence: true

  # Determine if the user should have access to this doctrine or not
  def accessible_to_user?(user)
    # Retrieve the doctrine's roles
    doctrine_roles = self.roles
    user_roles = user.roles
    # if access_by_hierarchy, then the doctrine should be accessible to all roles
    # listed and all roles >= the highest hierarchy among the listed roles
    if self.access_by_hierarchy
      # Determine highest of the doctrine's roles
      doctrine_hierarchy = doctrine_roles.pluck(:hierarchy_ranking).sort
      # Determine highest of the user's roles
      user_hierarchy = user_roles.pluck(:hierarchy_ranking).sort

      # Compare the two highest roles
      if user_hierarchy.last >= doctrine_hierarchy.last
        # if user is equal to or greater
        return true
      else
        # otherwise check for role match
        roles_match?(user_roles, doctrine_roles)
      end
    # if access_by_hierarchy is false, then
    else
      # Check if the roles match
      roles_match?(user_roles, doctrine_roles)
    end
  end

  def editable_by_user?(user)

  end

  def creatable_by_user?(user)
  end

  private
    def roles_match?(role_array_one, role_array_two)
      intersection = role_array_one & role_array_two
      if intersection.empty?
        return false
      else
        return true
      end
    end
end
