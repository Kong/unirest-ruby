require File.join(File.dirname(__FILE__), "/authentication.rb")

module Mashape
  class QueryAuthentication < Authentication
    def initialize(query_key, query_value)
      super()
      @params[query_key] = query_value
    end
  end
end

