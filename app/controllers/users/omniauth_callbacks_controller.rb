class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def eveonline
    puts "eve_crest_sso called"
    puts request.env["omniauth.auth"]
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.present?
      sign_in_and_redirect @user
    else
      flash[:alert] = "#{request.env["omniauth.auth"].info["name"]} is not a known member of this organization."
      redirect_to new_user_session_path
    end
    # Appears to handle processing of the data returned from omniauth
  end
end
