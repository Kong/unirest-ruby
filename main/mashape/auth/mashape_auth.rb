require File.join(File.dirname(__FILE__), "/header_auth.rb")
require File.join(File.dirname(__FILE__), "/../http/auth_util.rb")

module MashapeClient
  module Auth
    class MashapeAuth < HeaderAuth

      def initialize(public_key, private_key)
        super()
        @header = @header.merge(MashapeClient::HTTP::AuthUtil.generateMashapeAuthHeader(public_key, private_key))
      end
 
    end
  end
end


