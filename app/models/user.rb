# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default("0"), not null
#  unlock_token           :string
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string
#  uid                    :string
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :omniauthable, :omniauth_providers => [:eve]

  def self.from_omniauth(auth_hash)
    # Query for the characterID in the member table.
    member = Member.where("\"characterID\" = ?", auth.info["characterID"])

    if member.present?
      # If the member exists
      member = member[0]
      # Check if it is taken, if so
      if member.taken
        # Retrieve the user the member belongs to
        user = member.user
      else
        # Else, create a new user
        user = User.create(provider: auth.provider, main_character_name: auth.info["name"], main_character_id: auth.info["characterID"])
        # and update the member appropriately
        member.taken = true
        member.user_id = user.id
        member.save
      end
      # Return the user
      return user
    end
  end
    #where(provider: auth.provider, uid: auth.uid)
  #def self.from_omniauth(auth)
  #    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #      user.provider = auth.provider
  #      user.uid = auth.uid
  #      user.email = "luke.isla@gmail.com"
  #      user.password = Devise.friendly_token[0,20]
  #    end
  #end
end
