require File.join(File.dirname(__FILE__), "/header_auth.rb")
require File.join(File.dirname(__FILE__), "/../http/auth_util.rb")

module MashapeClient
  module Auth
    class BasicAuth < HeaderAuth

      def initialize(username, password)
        super()
        @header = @header.merge(MashapeClient::HTTP::AuthUtil.generateBasicAuthHeader(username, password))
      end
 
    end
  end
end


