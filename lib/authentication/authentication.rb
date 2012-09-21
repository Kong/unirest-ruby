module Mashape
    class Authentication
      
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
