require File.join(File.dirname(__FILE__), "/mashape_exception.rb")
require 'rubygems'
require 'json'
require 'uri'

module Mashape
  
  class HttpUtils
    
    def HttpUtils.uriEncode(value)
      return URI.escape(value)
    end
    
    def HttpUtils.setRequestHeaders(content_type, response_type, headers)
      headers["User-Agent"] = "mashape-ruby/2.0"
       
       case content_type
        when :json
         headers["Content-Type"] = "application/json"
        when :form
         headers["Content-Type"] = "application/x-www-form-urlencoded"
        when :binary
         headers["Content-Type"] = "multipart/form-data"
       end
       
       case response_type
         when :json
          headers["Accept"] = "application/json"
       end
    end
    
    def HttpUtils.setResponse(response, response_type, output_response)
        case response_type
          when :json
           begin
             output_response.body = JSON.parse(output_response.raw_body)
           rescue StandardError
             raise Mashape::JsonException.new("Can't parse the following response into JSON: " + output_response.raw_body)
           end
          else
           output_response.body = httpResponse.body
        end
    end
    
  end
  
end