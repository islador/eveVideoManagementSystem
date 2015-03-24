require 'omniauth'

module OmniAuth
  module Strategies
    class Eve
      include OmniAuth::Strategy

      provider = "eve"

      uid { 1 }

      def info
        {"name" => "islador"}
      end

      def request_phase
        redirect "#{Rails.application.secrets.crest_base_url}?response_type=code&redirect_uri=http://www.antigen.space/crest/authentication&client_id=#{Rails.application.secrets.crest_client_id}&scope=publicData&state=test_data"
      end

      def callback_phase
        # Base64 encode the inputs and strip the newline character appended at the end
        authorization_header = Base64.strict_encode64("#{Rails.application.secrets.crest_client_id}:#{Rails.application.secrets.crest_secret_key}")
        # Prepend it with 'Basic' as per docs https://developers.eveonline.com/resource/single-sign-on
        authorization_header = "Basic #{authorization_header}"
        authorization_code = request.params["code"]

        conn = Faraday.new(url: "https://login.eveonline.com") do |faraday|
          faraday.request :url_encoded
          faraday.response :logger
          faraday.adapter Faraday.default_adapter
        end

        token_query_response = conn.post do |req|
          req.url "/oauth/token"
          req.headers["Authorization"] = authorization_header
          req.body = {"grant_type" => "authorization_code", "code" => "#{authorization_code}"}
        end

        json_token_query_response = JSON.parse(token_query_response.body)

        character_query_response = conn.get do |req|
          req.url "/oauth/verify"
          req.headers["Authorization"] = "Bearer #{json_token_query_response["access_token"]}"
        end

        json_character_query_response = JSON.parse(character_query_response.body)
        puts json_character_query_response

        env['omniauth.auth'] = auth_hash
        #puts request.env["omniauth.auth"].to_yaml
        call_app!
      end
    end
  end
end
