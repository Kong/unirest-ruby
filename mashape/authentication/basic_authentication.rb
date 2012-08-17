require File.join(File.dirname(__FILE__), "/header_authentication.rb")
require File.join(File.dirname(__FILE__), "/authentication_utils.rb")

module Mashape
    class BasicAuthentication < Mashape::HeaderAuthentication

      def initialize(username, password)
        super()
        @header = @header.merge(Mashape::AuthenticationUtils.generateBasicAuthHeader(username, password))
      end
 
    end
end

