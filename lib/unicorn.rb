require 'rubygems'
require 'rest-client'

require File.join(File.dirname(__FILE__), "/http_request.rb")
require File.join(File.dirname(__FILE__), "/http_response.rb")

module Unicorn
  
  USER_AGENT = "unicorn-ruby/1.0"
  
  class HttpClient
  
    def self.request(method, url, headers, body, &callback)
      http_request = Unicorn::HttpRequest.new(method, url, headers, body)
      
      if callback
        return Thread.new do
          callback.call(self.internal_request(http_request))
        end
      else
        return self.internal_request(http_request)
      end
    end
    
    def self.internal_request(http_request)      
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
            http_response = RestClient.delete http_request.url, http_request.headers
          when :patch
            http_response = RestClient.patch http_request.url, http_request.body, http_request.headers
        end
      rescue => e
        http_response = e.response
      end

      return Unicorn::HttpResponse.new(http_response)
    end
    
  end

  def self.get(url, headers = {}, &callback)
    return HttpClient.request(:get, url, headers, nil, &callback)
  end
    
  def self.post(url, body = nil, headers = {}, &callback)
    return HttpClient.request(:post, url, headers, body, &callback)
  end
    
  def self.delete(url, headers = {}, &callback)
    return HttpClient.request(:delete, url, headers, nil, &callback)
  end
    
  def self.put(url, body = nil, headers = {}, &callback)
    return HttpClient.request(:put, url, headers, body, &callback)
  end
    
  def self.patch(url, body = nil, headers = {}, &callback)
    return HttpClient.request(:patch, url, headers, body, &callback)
  end
  
end