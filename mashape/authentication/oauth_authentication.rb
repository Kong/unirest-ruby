require File.join(File.dirname(__FILE__), "/authentication.rb")

module Mashape
  class OAuthAuthentication < Authentication
    
    def initialize(consumer_key, consumer_secret, redirect_url)
      super()
      @params[:consumer_key] = consumer_key
      @params[:consumer_secret] = consumer_secret
      @params[:redirect_url] = redirect_url
    end
  end
end