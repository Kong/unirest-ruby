
module MashapeClient
  module Auth
    class Auth
      
      def initialize() 
        @header = Hash.new
        @params = Hash.new 
      end

      def handleHeader()
        return @header
      end

      def handleParams()
        return @params
      end
 
    end
  end
end
