require File.join(File.dirname(__FILE__), "/auth.rb")

module MashapeClient
  module Auth
    class QueryAuth < Auth

      def initialize(query_key, query_value)
        super()
        @params[query_key] = query_value
      end
 
    end
  end
end

