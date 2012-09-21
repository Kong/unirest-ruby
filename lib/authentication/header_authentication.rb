require File.join(File.dirname(__FILE__), "/authentication.rb")

module Mashape
  class HeaderAuthentication < Mashape::Authentication

    def initialize()
      super()
    end

  end
end