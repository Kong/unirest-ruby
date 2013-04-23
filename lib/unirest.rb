# The MIT License
#
# Copyright (c) 2013 Mashape (http://mashape.com)

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
# 
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
# 

require 'rubygems'
require 'rest-client'

require File.join(File.dirname(__FILE__), "/unirest/http_request.rb")
require File.join(File.dirname(__FILE__), "/unirest/http_response.rb")

module Unirest
  
  USER_AGENT = "unirest-ruby/1.0"
  
  class HttpClient
  
    def self.request(method, url, headers, body, &callback)
      http_request = Unirest::HttpRequest.new(method, url, headers, body)
      
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

      return Unirest::HttpResponse.new(http_response)
    end
    
  end

  def self.get(url, headers = {}, &callback)
    return HttpClient.request(:get, url, headers, nil, &callback)
  end
    
  def self.post(url, headers = {}, body = nil, &callback)
    return HttpClient.request(:post, url, headers, body, &callback)
  end
    
  def self.delete(url, headers = {}, &callback)
    return HttpClient.request(:delete, url, headers, nil, &callback)
  end
    
  def self.put(url, headers = {}, body = nil, &callback)
    return HttpClient.request(:put, url, headers, body, &callback)
  end
    
  def self.patch(url, headers = {}, body = nil, &callback)
    return HttpClient.request(:patch, url, headers, body, &callback)
  end
  
end