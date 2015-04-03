# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  sign_in_count       :integer          default("0"), not null
#  current_sign_in_at  :datetime
#  last_sign_in_at     :datetime
#  current_sign_in_ip  :inet
#  last_sign_in_ip     :inet
#  created_at          :datetime
#  updated_at          :datetime
#  provider            :string
#  uid                 :string
#  main_character_name :string
#  main_character_id   :integer
#

class User < ActiveRecord::Base
  devise :trackable, :omniauthable, :omniauth_providers => [:eveonline]

  has_many :members
  has_many :roles
  has_and_belongs_to_many :roles
  has_many :missions
  has_many :mission_groups

  def self.from_omniauth(auth_hash)
    # Query for the characterID in the member table.
    member = Member.where("\"characterID\" = ?", auth_hash.info["CharacterID"])

    if member.present?
      # If the member exists
      member = member[0]
      # Check if it is taken, if so
      if member.taken
        # Retrieve the user the member belongs to
        user = member.user
      else
        # Else, create a new user
        user = User.create(provider: auth_hash.provider, main_character_name: auth_hash.info["name"], main_character_id: auth_hash.info["CharacterID"])

        # Set the user's role via batch insertion
        roles_user_array = []
        member_roles = member.roles.pluck(:id)
        member_roles.each do |role_id|
          roles_user_array << {user_id: user.id, role_id: role_id}
        end
        RolesUser.create(roles_user_array)

        # and update the member appropriately
        member.taken = true
        member.user_id = user.id
        member.save
      end
      # Return the user
      return user
    else
      user = User.where("main_character_id = ?", auth_hash.info["CharacterID"])
      unless user.present?
        # Determine the user's role (and thus access level)
        role_ids = determine_role(auth_hash.info["CharacterID"])

        # If a role cannot be found for the user, return nil
        if role_ids.present?
          # otherwise, create a new user
          user = User.create(provider: auth_hash.provider, main_character_name: auth_hash.info["name"], main_character_id: auth_hash.info["CharacterID"])

          # Set the user's role(s)
          roles_user_array = []
          role_ids.each do |role_id|
            roles_user_array << {user_id: user.id, role_id: role_id}
          end
          RolesUser.create(roles_user_array)
        end
      end

      # Return the user
      return user
    end
  end

  # Determine_role does not yet support multiple role returns. This will need to be a feature later.
  def self.determine_role(character_id)
    # Generate an EVE API object without vCode && keyID
    public_query_api = Eve::API.new()

    # Query character info
    character_info = public_query_api.eve.character_info(character_id)

    # Query for the character's corporation's info
    corporation_info = public_query_api.corporation.corporation_sheet(character_info.result["corporationID"])

    # If the corporation is in the Caldari Militia
    if corporation_info.result["factionID"] == 500001
      role_id = Role.where("name = ?", "Militia Member")[0].id
    end
  end

  # Return the roles of less then or equal hierarchy ranking to that of the user's
  def less_or_equal_roles
    # Retrieve the hierarchy_ranking of the user's roles
    self_ranking = self.roles.pluck(:hierarchy_ranking)
    # Sort them so that the highest is at the end of the returned array
    self_ranking_sorted = self_ranking.sort
    # Retrieve the roles with ranking equal or below that
    roles = Role.where("hierarchy_ranking <= ?", self_ranking_sorted.last)
  end


  def director
    # Retrieve the director and ceo role IDs from the database
    director_ceo_role_ids = Role.where(name: ["Corp Director", "Corp CEO"]).pluck(:id)

    # See if the user has those roles.
    RolesUser.where(role_id: director_ceo_role_ids, user_id: self.id)[0].present?
  end

  def member
    # Retrieve the role ids a corp member might have.
    member_role_ids = Role.where(name: ["Corp Member", "Corp Director", "Corp CEO"]).pluck(:id)

    # See if the user has those roles.
    RolesUser.where(role_id: member_role_ids, user_id: self.id).length > 0
  end
end
