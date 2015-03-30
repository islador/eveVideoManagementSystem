require 'net/http'
require 'net/https'
require 'uri'

class CrestController < ApplicationController
  def login
  end

  def authenticate
    redirect_to("#{Rails.application.secrets.crest_base_url}?response_type=code&redirect_uri=http://www.antigen.space/crest/authentication&client_id=#{Rails.application.secrets.crest_client_id}&scope=publicData&state=test_data")
  end

  def callback
    # Base64 encode the inputs and strip the newline character appended at the end
    authorization_header = Base64.strict_encode64("#{Rails.application.secrets.crest_client_id}:#{Rails.application.secrets.crest_secret_key}")
    # Prepend it with 'Basic' as per docs https://developers.eveonline.com/resource/single-sign-on
    authorization_header = "Basic #{authorization_header}"

    authorization_code = "IsLTEhLOLI8ShMC-lGjdrkrTt89pOHQEMY3Zu0ilKk3VzklWnW9xsfgfsbdwX5go0"
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

    user = warden.authenticate!({:scope => :user, recall: "devise/sessions/#new"})
    #user = warden.authenticate!({"user" => {"email" => "luke.isla@gmail.com", "password" => "goblin1swatuy"}})
    sign_in(:user, user)
    redirect_to root_path
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
end
