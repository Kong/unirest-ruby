require File.join(File.dirname(__FILE__), "/header_authentication.rb")
require File.join(File.dirname(__FILE__), "/authentication_utils.rb")

module Mashape
  class MashapeAuthentication < HeaderAuthentication

    def initialize(public_key, private_key)
      super()
      @header = @header.merge(Mashape::AuthenticationUtils.generateMashapeAuthHeader(public_key, private_key))
    end

  end
end


