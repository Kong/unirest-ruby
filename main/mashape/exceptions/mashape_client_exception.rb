require File.join(File.dirname(__FILE__), "/exception_constants.rb")
module MashapeClient
  module Exceptions
    class MashapeClientException < StandardError
      
      attr_reader :code
      def initialize(message, code)
        super(message)
        @code = code
      end
      
    end
  end
end