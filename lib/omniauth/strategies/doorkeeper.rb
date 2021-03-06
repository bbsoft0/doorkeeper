module OmniAuth
  module Strategies
    class Doorkeeper < OmniAuth::Strategies::OAuth2
      option :name, :doorkeeper

      option :client_options,
             site: ENV["DOORKEEPER_APP_URL"],
             authorize_url: "/auth/login",
             token_url: "/auth/code/access"
             uid do
        raw_info["id"]
      end

      info do
        {
          email: raw_info["email"]
        }
      end

      def raw_info
        @raw_info ||= access_token.get("/auth/user-profile").parsed
          #@raw_info ||= access_token.get("/api/v1/me.json").parsed
      end

      # def build_access_token
      #  Rails.logger.debug "Omniauth build access token"
      #  options.token_params.merge!(:headers => {'Authorization' => basic_auth_header })
      #  super
      #end

      #def basic_auth_header
      #  "Bearer " + Base64.strict_encode64("#{request.params["code"]}")
      #end

    end
  end
end
