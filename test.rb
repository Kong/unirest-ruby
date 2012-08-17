require File.join(File.dirname(__FILE__), "/mashape/mashape")

class Test 
  PUBLIC_DNS = "mashaper-test.p.mashape.com"

  def initialize(public_key, private_key, consumer_key, consumer_secret, redirect_url)
    @authentication_handlers = Array.new
    @authentication_handlers << Mashape::MashapeAuthentication.new(public_key, private_key)
    # @authentication_handlers << Mashape::OAuthAuthentication.new(consumer_key, consumer_secret, redirect_url)
  end

#  def authenticate_oauth(access_token, access_secret = nil)
#     @authentication_handlers.each do |handler|
#       if handler.kind_of? Mashape::OAuthAuthentication
#         handler.handleParams[:access_token] = access_token
#         handler.handleParams[:access_secret] = access_secret
#         break
#       end
#     end
#     return self
#   end
   
#   def get_oauth_url
#     return "https://" + PUBLIC_DNS + "/oauth"
#   end

  def getHello(name, &callback)
    parameters = {"_method" => "getHello", "name" => name}
    return Mashape::HttpClient.do_request(:get, "https://" + PUBLIC_DNS + "/api.php", parameters, :form, :json, @authentication_handlers, &callback)
  end
  
  def postHello(name, &callback)
    parameters = {"_method" => "postHello", "name" => name}
    return Mashape::HttpClient.do_request(:get, "https://" + PUBLIC_DNS + "mashaper-test.p.mashape.com/api.php", parameters, :form, :json, @authentication_handlers, &callback)
  end
  
end

test = Test.new("public", "private", "consumer-key", "consumer-secret", "http://mashape.com/validate");

#test.authenticate_oauth("access-token")

puts test.getHello("Marco").body
puts test.getHello("Marco").body
puts test.getHello("Marco").body

# puts test.authenticate_oauth("access-token").getHello("Marco").body