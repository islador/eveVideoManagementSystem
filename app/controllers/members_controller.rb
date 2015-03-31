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

      redirect_to members_path
    rescue EVE::Errors::AuthenticationError => e
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
end
