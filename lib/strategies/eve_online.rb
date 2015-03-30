require 'omniauth'

module OmniAuth
  module Strategies
    class Eveonline
      include OmniAuth::Strategy

      provider = "Eveonline"

      def uid
        "#{options["character"]["CharacterID"]}"
      end

      def info
        {
          "CharacterID" => options["character"]["CharacterID"],
          "name" => options["character"]["CharacterName"],
          "ExpiresOn" => options["character"]["ExpiresOn"],
          "Scopes" => options["character"]["Scopes"],
          "TokenType" => options["character"]["TokenType"],
          "CharacterOwnerHash" => options["character"]["CharacterOwnerHash"]
        }
      end

      def credentials
        {"access_token" => options["credentials"][:access_token],
          "token_type" => options["credentials"][:token_type],
          "expires_in" => options["credentials"][:expires_in],
          "refresh_token" => options["credentials"][:refresh_token]
        }
      end

      def request_phase
        options.store("state", SecureRandom.hex(24))
        redirect "#{Rails.application.secrets.crest_base_url}?response_type=code&redirect_uri=#{Rails.application.secrets.crest_callback_url}&client_id=#{Rails.application.secrets.crest_client_id}&scope=publicData&state=#{options["state"]}"
      end

      def callback_phase
        if request.params["state"] == options["state"]
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

          options.store("credentials", {
            access_token: json_token_query_response["access_token"],
            token_type: json_token_query_response["token_type"],
            expires_in: json_token_query_response["expires_in"],
            refresh_token: json_token_query_response["refresh_token"]
          })

          character_query_response = conn.get do |req|
            req.url "/oauth/verify"
            req.headers["Authorization"] = "Bearer #{json_token_query_response["access_token"]}"
          end

          json_character_query_response = JSON.parse(character_query_response.body)

          options.store("character", {
            "CharacterID" => json_character_query_response["CharacterID"],
            "CharacterName" => json_character_query_response["CharacterName"],
            "ExpiresOn" => json_character_query_response["ExpiresOn"],
            "Scopes" => json_character_query_response["Scopes"],
            "TokenType" => json_character_query_response["TokenType"],
            "CharacterOwnerHash" => json_character_query_response["CharacterOwnerHash"]
            })

          env['omniauth.auth'] = auth_hash
          #puts request.env["omniauth.auth"].to_yaml
          call_app!
        else
          env['omniauth.auth'] = auth_hash
          call_app!
        end
      end
    end
  end
end
