require 'rubygems'
require 'base64'
require 'hmac-sha1'

module Mashape
    class AuthenticationUtils
      
      def AuthenticationUtils.generateMashapeAuthHeader(public_key, private_key)
        unless public_key.empty? || private_key.empty?
          hash = HMAC::SHA1.hexdigest(private_key, public_key)
          auth = {"X-Mashape-Authorization" => Base64.encode64(public_key + ":" + hash).chomp.gsub(/\n/,'')}
        end
        return auth
      end
      
      def AuthenticationUtils.generateBasicAuthHeader(username, password)
        unless username.empty? || password.empty?
          auth = {"Authorization" => "Basic " + Base64.encode64(username + ":" + password).chomp.gsub(/\n/,'')}
        end
        return auth
      end
 
    end
end