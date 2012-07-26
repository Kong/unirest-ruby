require File.join(File.dirname(__FILE__), "/header_auth.rb")

module MashapeClient
  module Auth
    class CustomHeaderAuth < HeaderAuth

      def initialize(header_name, header_value)
        super()
        @header[header_name] = header_value
      end
 
    end
  end
end

