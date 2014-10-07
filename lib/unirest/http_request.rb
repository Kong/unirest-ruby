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

require 'addressable/uri'
require "base64"

module Unirest
  
  class HttpRequest
    attr_reader :method
    attr_reader :url 
    attr_reader :headers
    attr_reader :body
    attr_reader :auth
    
    def add_header(name, value)
      @headers[name] = value
    end
    
    def initialize(method, url, headers = {}, body = nil, auth = nil)
      @method = method
      
      if (method == :get)
        if body.is_a?(Hash) && body.length > 0
          if url.include? "?"
            url += "&"
          else
            url += "?"
          end

          uri = Addressable::URI.new
          uri.query_values = body
          url += uri.query
        end
      else
         @body = body
      end

      unless url =~ URI.regexp
        raise "Invalid URL: " + url
      end
      
      @url = url.gsub /\s+/, '%20'
      
      @headers = {}

      if auth != nil && auth.is_a?(Hash)
        user = ""
        password = ""
        if auth[:user] != nil
          user = auth[:user]
        end
        if auth[:password] != nil
          password = auth[:password]
        end

        headers['Authorization'] = 'Basic ' + ["#{user}:#{password}"].pack('m').delete("\r\n")

      end


      # Make the header key lowercase
      headers.each_pair {|key, value| @headers[key.downcase] = value }
    end
    
  end
  
end
