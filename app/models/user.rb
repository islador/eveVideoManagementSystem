# == Schema Information
#
# Table name: users
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
        user = User.create(provider: auth_hash.provider, main_character_name: auth_hash.info["name"], main_character_id: auth_hash.info["CharacterID"])
        # and update the member appropriately
        member.taken = true
        member.user_id = user.id
        member.save
      end
      # Return the user
      return user
    end
  end
end
