require 'rubygems'
require 'rest-client'
require 'addressable/uri'

require File.join(File.dirname(__FILE__), "/http_request.rb")
require File.join(File.dirname(__FILE__), "/http_response.rb")

module MashapeRest
  
  USER_AGENT = "mashape-ruby/3.0"
  
  class HttpClient
  
    def self.request(method, url, headers, body, &callback)
      
      http_request = MashapeRest::HttpRequest.new(method, url, headers, body)
      
      if callback
        return Thread.new do
          callback.call(self.internal_request(http_request))
        end
      else
        return self.internal_request(http_request)
      end
    end
    
    def self.internal_request(http_request)
      
      if http_request == nil
        raise "Create a valid HttpRequest object"
      end
    
      # Set the user agent
      http_request.add_header("user-agent", USER_AGENT)
      
      http_response = nil;
    
      begin
        case http_request.method
          when :get
            http_response = RestClient.get http_request.url, http_request.headers
          when :post
             http_response = RestClient.post http_request.url, http_request.body, http_request.headers
          when :put
            http_response = RestClient.put http_request.url, http_request.body, http_request.headers
          when :delete
            http_response = RestClient.delete http_request.url, http_request.body, http_request.headers
          when :patch
            http_response = RestClient.patch http_request.url, http_request.body, http_request.headers
        end
      rescue => e
        http_response = e.response
      end
      
      return MashapeRest::HttpResponse.new(http_response)
    end
    
  end

  def self.get(url, headers = {}, &callback)
    return HttpClient.request(:get, url, headers, nil, &callback)
  end
    
  def self.post(url, headers = {}, body = nil, &callback)
    return self.request(:post, url, headers, body, &callback)
  end
    
  def self.delete(url, headers = {}, body = nil, &callback)
    return self.request(:delete, url, headers, body, &callback)
  end
    
  def self.put(url, headers = {}, body = nil, &callback)
    return self.request(:put, url, headers, body, &callback)
  end
    
  def self.patch(url, headers = {}, body = nil, &callback)
    return self.request(:patch, url, headers, body, &callback)
  end
  
end