class SessionsController < ApplicationController
  #prepend_before_filter :require_no_authentication, only: [ :new, :create, :callback]

  def new
  end

  def create
    puts "sessions create"
    self.resource = warden.authenticate!(:eve_authenticatable)
    #set_flash_message(:notice, :signed_in) if is_flashing_format?
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def authenticate
    redirect_to("#{Rails.application.secrets.crest_base_url}?response_type=code&redirect_uri=http://www.antigen.space/crest/authentication&client_id=#{Rails.application.secrets.crest_client_id}&scope=publicData&state=test_data")
  end

  def callback
    # Base64 encode the inputs and strip the newline character appended at the end
    authorization_header = Base64.strict_encode64("#{Rails.application.secrets.crest_client_id}:#{Rails.application.secrets.crest_secret_key}")
    # Prepend it with 'Basic' as per docs https://developers.eveonline.com/resource/single-sign-on
    authorization_header = "Basic #{authorization_header}"

    authorization_code = "YmhpVwrcXiYi8RdRJlUt25rEihRQ7ivvo8T4XVEwvRhoCmBil85BaCBPVu3_yyXE0"
    #authorization_code = params[:code]

    token_query_response = HTTParty.post("https://login.eveonline.com/oauth/token", {
      body: {"grant_type" => "authorization_code", "code" => "#{authorization_code}"},
      headers: {"Authorization" => authorization_header}
      })

    json_token_query_response = JSON.parse(token_query_response.body)

    character_query_response = HTTParty.get("https://login.eveonline.com/oauth/verify", {
      headers: {"Authorization" => "Bearer #{json_token_query_response["access_token"]}"}
      })

    json_character_query_response = JSON.parse(character_query_response.body)
    puts json_character_query_response
    #self.auth_options = json_character_query_response
    #query_response = json_character_query_response
    create
    #user = warden.authenticate!({:scope => :user, recall: "devise/sessions/#new"})
    #user = warden.authenticate!({"user" => {"email" => "luke.isla@gmail.com", "password" => "goblin1swatuy"}})
    #sign_in(:user, user)
    #redirect_to root_path

    #authenticate_user!({"user" => json_character_query_response})
    #derp = HTTParty.post("http://localhost:3000#{user_session_path}", {
    #  body: {"user" => json_character_query_response}
    #  })

    #redirect_to new_user_session_path({"user" => json_character_query_response})

    #sign_in()
    #sign_in({"user" => json_character_query_response})
    #user_session_path(json_character_query_response)

    #render nothing: true
  end

  private

end
