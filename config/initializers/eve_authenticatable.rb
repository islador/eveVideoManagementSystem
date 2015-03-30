#require 'net/ldap'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class EVEAuthenticatable < Authenticatable
      def authenticate!
        puts "\n EVE Authenticate! \n"
        puts "Character Slug: #{params}"
        #if params[:user]
          #ldap = Net::LDAP.new
          #ldap.host = [YOUR LDAP HOSTNAME]
          #ldap.port = [YOUR LDAP HOSTNAME PORT]
          #ldap.auth email, password
          #puts "#{email}"
          #if ldap.bind
            user = User.find_or_create_by(email: email)
            success!(user)
          #else
          #  fail(:invalid_login)
          #end
        #end
      end

      def email
        "luke.isla@gmail.com"
        #params[:user][:email]
      end

      def password
        #"goblin1swatuy"
        #params[:user][:password]
      end

    end
  end
end

Warden::Strategies.add(:eve_authenticatable, Devise::Strategies::EVEAuthenticatable)
