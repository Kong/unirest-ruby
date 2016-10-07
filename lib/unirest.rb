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

  @@timeout         = 10
  @@default_headers = {}
  @@proxy           = nil
  @@user_agent      = "unirest-ruby/1.1"

  class HttpClient
    def self.request(method, url, headers, body, auth, timeout, proxy, &callback)
      http_request = Unirest::HttpRequest.new(method, url, headers, body, auth)

      if callback
        return Thread.new do
          callback.call(self.internal_request(http_request, timeout,proxy))
        end
      else
        return self.internal_request(http_request, timeout,proxy)
      end
    end

    def self.internal_request(http_request, timeout, proxy)
      # Set the user agent
      http_request.add_header("user-agent", Unirest.user_agent)
      http_request.add_header("accept-encoding", "gzip")
      http_response = nil

      begin
        RestClient.proxy = proxy unless proxy.nil?
        http_response = RestClient::Request.execute(:method => http_request.method.to_sym, :url => http_request.url, :headers => http_request.headers, :timeout => timeout, payload: (http_request.method != :get) ? http_request.body : nil)
      rescue RestClient::RequestTimeout
        raise 'Request Timeout'
      rescue RestClient::Exception => e
        http_response = e.response
      end

      Unirest::HttpResponse.new(http_response)
    end

  end

  def self.default_header(name, value)
    @@default_headers[name] = value
  end

  def self.clear_default_headers
    @@default_headers = {}
  end

  def self.timeout(seconds)
    @@timeout = seconds
  end

  def self.proxy(url)
    @@proxy = url
  end

  def self.user_agent(user_agent=@@user_agent)
    if user_agent
      @@user_agent = user_agent
    else
      @@user_agent
    end
  end

  def self.get(url, headers: {}, parameters: nil, auth:nil, &callback)
    return HttpClient.request(:get, url, headers.merge(@@default_headers), parameters, auth, @@timeout, @@proxy, &callback)
  end

  def self.post(url, headers: {}, parameters: nil, auth:nil, &callback)
    return HttpClient.request(:post, url, headers.merge(@@default_headers), parameters, auth, @@timeout, @@proxy, &callback)
  end

  def self.delete(url, headers: {}, parameters: nil, auth:nil, &callback)
    return HttpClient.request(:delete, url, headers.merge(@@default_headers), parameters, auth, @@timeout, @@proxy, &callback)
  end

  def self.put(url, headers: {}, parameters: nil, auth:nil, &callback)
    return HttpClient.request(:put, url, headers.merge(@@default_headers), parameters, auth, @@timeout, @@proxy, &callback)
  end

  def self.patch(url, headers: {}, parameters: nil, auth:nil, &callback)
    return HttpClient.request(:patch, url, headers.merge(@@default_headers), parameters, auth, @@timeout, @@proxy, &callback)
  end

end
