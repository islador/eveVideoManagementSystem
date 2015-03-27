class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def eve
    puts "eve_crest_sso called"
    puts request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
    # Appears to handle processing of the data returned from omniauth
  end
end
