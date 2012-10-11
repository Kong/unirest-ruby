require File.join(File.dirname(__FILE__), "/authentication.rb")

module Mashape
  class OAuthAuthentication < Authentication
    
    def initialize(consumer_key, consumer_secret, callback_url)
      super()
      @params[:consumer_key] = consumer_key
      @params[:consumer_secret] = consumer_secret
      @params[:callback_url] = callback_url
    end
  end
end