require File.join(File.dirname(__FILE__), "/header_authentication.rb")

module Mashape
    class CustomHeaderAuthentication < HeaderAuthentication

      def initialize(header_name, header_value)
        super()
        @header[header_name] = header_value
      end
 
    end
end
