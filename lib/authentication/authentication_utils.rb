require 'rubygems'
require 'base64'
require 'hmac-sha1'

module Mashape
    class AuthenticationUtils
      
      def AuthenticationUtils.generateMashapeAuthHeader(public_key, private_key)
        return {"X-Mashape-Authorization" => mashape_key}
      end
      
      def AuthenticationUtils.generateBasicAuthHeader(username, password)
        unless username.empty? || password.empty?
          auth = {"Authorization" => "Basic " + Base64.encode64(username + ":" + password).chomp.gsub(/\n/,'')}
        end
        return auth
      end
 
    end
end