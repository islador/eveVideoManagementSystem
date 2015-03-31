class MembersController < ApplicationController
  def add_new_api
  end

  def add_temporary_member
  end

  def refresh_member_list
    begin
      eve_api = Eve::API.new(key_id: "4233755", v_code: "1fu1tvYX38Ub5GE6K6W7zc1DWAd5UMpNzebSX32ZSapWmRBOMk00duZKDSDhLaKf")
      result = eve_api.account.apikeyinfo
      eve_api[:character_id] = result.key.characters[0].character_id
      # Query EVE for the list of members in the corporation
      member_list = eve_api.corporation.member_tracking
      # Query EVE for their roles
      member_security = eve_api.corporation.member_security

      member_hash = {}
      # Construct a hash containing the value returned from the member_list query.
      # This can be extended to include data from multiple queries; this is done to mitigate DB hits
      member_list.rowsets[0].each do |member|
        member_hash.store("#{member.character_id}", {"characterID" => member.character_id, "name" => member.name, "startDateTime" => member.start_date_time, "baseID" => member.base_id, "base" => member.base, "title" => member.title})
      end

      # Append the massaged roles into the member_hash
      member_security.members.each do |member|
        # Massage the returned roles data into this applications role's hash
        member_roles = {}
        member["roles"].each do |role|
          name = role.role_name.slice(4, role.role_name.length)
          member_roles.store("Corp #{name}", true)
        end
        # Find the proper member in the member_hash
        member_hash_value = member_hash["#{member.character_id}"]
        # Set it's roles hash to the freshly created roles hash
        member_hash_value.store("roles", member_roles)
      end

      # We want to add new members and update existing members,
      # Iterate over each member returned from the API
      member_hash.each do |key, value|
        # Search for the member in the database
        member = Member.where("\"characterID\" = ?", key)
        if member.present?
          # If found, update the existing member
          member[0].update_attributes(value)
        else
          # Else, create a new member
          Member.create(value)
        end
      end

      # We want to remove ex-members from the list. To do this,
      # Query for all the members NOT in the hash
      old_members = Member.where("\"characterID\" NOT IN (?)", member_hash.keys)
      # Iterate through the returned members and delete them.
      old_members.each do |member|
        member.destroy
      end

      # Update the roles of all users to match changes in members and game state.
      update_user_roles

      redirect_to members_path
    rescue Eve::Errors::AuthenticationError => e
      flash[:alert] = "Member Pull Failed, check logs"
      redirect_to members_path
    end
  end

  def index
    @members = Member.all
  end

  def show
  end

  def create
  end

  private
    # update_user_roles ensures that a user does not have any roles they shouldn't have.
    # Ideally it will be shuttled into a sidekiq worker once we migrate off heroku.
    # update_user_roles must be run AFTER refresh_member_list
    def update_user_roles
      #
      # Note: this method suports multiple roles, but relies on User.determine_role,
      # which does not support multiple roles
      #
      users = User.all
      users.each do |user|
        members = user.members
        # Check if the user has a member
        if members.present?
          # If so, clear the user's roles hash
          user.roles = {}
          members.each do |member|
            # and copy the user's current roles into the newly cleared hash
            user.roles.merge(member.roles)
          end
        else
          # otherwise, determine the user's roles
          user_role = User.determine_role(user.main_character_id)
          # If the user has no known roles, destroy that user.
          if user_role == "Unknown"
            user.destroy
          else
            # Otherwise, compare the user's existing roles
            unless user.roles == {"#{user_role}" => true}
              # If they don't match, set the user's roles to the returned role.
              user.roles = {"#{user_role}" => true}
            end
          end
        end
      end
    end
end
