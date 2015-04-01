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

      # Update the roles of all members to match their in game state
      update_member_roles

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

    # Assemble a hash comprising the name of each role a member has. This is DB and
    # time intensive and likely not worth it
    role_names = Role.all.pluck(:id, :name)
    role_hash = {}
    role_names.each do |role|
      role_hash.store("#{role[0]}", "#{role[1]}")
    end

    @members_roles_hash = {}

    @members.each do |member|
      role_ids = member.roles.pluck(:id)
      member_role_names = []
      role_ids.each do |role_id|
        member_role_names << role_hash["#{role_id}"]
      end
      @members_roles_hash.store("#{member.characterID}", member_role_names)
    end
  end

  def show
  end

  def create
  end

  private
    # Update the roles of every member in the database to match the in game state of that member
    def update_member_roles
      eve_api = Eve::API.new(key_id: "4233755", v_code: "1fu1tvYX38Ub5GE6K6W7zc1DWAd5UMpNzebSX32ZSapWmRBOMk00duZKDSDhLaKf")
      result = eve_api.account.apikeyinfo
      eve_api[:character_id] = result.key.characters[0].character_id
      # Query EVE for member roles
      member_security = eve_api.corporation.member_security


      # Find the roles the member should have
      members = {}
      # Iterate over each returned member
      member_security.members.each do |member|
        # Build a hash of each member's roles, keyed by character_id
        members.store("#{member.character_id}" => [])
        # Retrieve the member's roles from the returned API data
        member["roles"].each do |role|
          # Since member's roles appear to start with 'role', slice it off
          name = role.role_name.slice(4, role.role_name.length)
          # Append 'Corp' to match the role names and insert it into the member's role array
          members["#{member.character_id}"] << "Corp #{name}"
        end
      end

      # Iterate over each member in the members hash
      members.each do |key, value|
        # Retrieve the member using the character_id key in the members hash
        member = Member.where("\"characterID\" = ?", key)[0]
        # Find the member's current roles
        roles = member.roles.pluck(:id, :name)
        # If there are current roles
        if roles.present?
          # iterate over each existing role and remove any the member should no longer have
          roles.each do |role|
            # if the member should have the role
            if value.include?(role[1])
              # delete that role from the hash value
            else
              # otherwise, delete the role from the member
              MembersRole.where("member_id = ? AND role_id = ?", member.id, role[0])[0].destroy
            end
          end
        end

        # Retrieve the IDs of each remaining role from the database
        role_ids = Role.where(name: value).pluck(:id)
        # Iterate over the role_ids array building a hash for batch insertion
        members_role_array = []
        role_ids.each do |role_id|
          members_role_array << {member_id: member.id, role_id: role_id}
        end
        # Batch insert the new MembersRoles into the database
        MembersRole.create(members_role_array)
      end
    end

    # update_user_roles ensures that a user does not have any roles they shouldn't have.
    # Ideally it will be shuttled into a sidekiq worker once we migrate off heroku.
    # update_user_roles must be run AFTER refresh_member_list
    def update_user_roles
      #
      # Note: this method supports multiple roles, but relies on User.determine_role,
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
