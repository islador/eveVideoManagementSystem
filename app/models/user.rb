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
#  roles               :hstore
#

class User < ActiveRecord::Base
  devise :trackable, :omniauthable, :omniauth_providers => [:eveonline]

  has_many :members

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
        user = User.create(provider: auth_hash.provider, main_character_name: auth_hash.info["name"], main_character_id: auth_hash.info["CharacterID"], roles: {})
        # Set the user's role
        user.roles.store("Corp Member", true)

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
        role = determine_role(auth_hash.info["CharacterID"])

        # If the user's role is unknown, return nil, otherwise
        unless role == "Unknown"
          # Create a new user
          user = User.create(provider: auth_hash.provider, main_character_name: auth_hash.info["name"], main_character_id: auth_hash.info["CharacterID"], roles: {})

          # Set the user's role
          user.roles.store(role, true)
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
      role = "Militia Member"
    else
      role = "Unknown"
    end
  end
end
