require 'rubygems'
require 'addressable/uri'
require 'rest-client'
require 'json'
require File.join(File.dirname(__FILE__), "/authentication/mashape_authentication.rb")
require File.join(File.dirname(__FILE__), "/authentication/custom_header_authentication.rb")
require File.join(File.dirname(__FILE__), "/authentication/query_authentication.rb")
require File.join(File.dirname(__FILE__), "/authentication/basic_authentication.rb")
require File.join(File.dirname(__FILE__), "/authentication/oauth_authentication.rb")
require File.join(File.dirname(__FILE__), "/authentication/oauth10a_authentication.rb")
require File.join(File.dirname(__FILE__), "/authentication/oauth2_authentication.rb")
require File.join(File.dirname(__FILE__), "/http_utils.rb")
require File.join(File.dirname(__FILE__), "/mashape_exception.rb")

module Mashape
  class HttpResponse
    attr :code, true
    attr :raw_body, true  
    attr :body, true
    attr :headers, true
  end
  
  class HttpClient
    
    def HttpClient.do_request(method, url, parameters = nil, content_type = nil, response_type = nil, authentication_handlers = nil, &callback)
      if callback
        return Thread.new do
          callback.call(internal_do_request(method, url, parameters, content_type, response_type, authentication_handlers))
        end
      else
        return internal_do_request(method, url, parameters, content_type, response_type, authentication_handlers)
      end
    end
    
    def HttpClient.internal_do_request(method, url, parameters = nil, content_type = nil, response_type = nil, authentication_handlers = nil)
       httpResponse = nil;
       
       headers = {}
       if parameters == nil
            parameters = {}
       end
       
       # figure out what kind of auth we have and where to put it
       authentication_handlers.each do |handler|
         if handler.kind_of? Mashape::HeaderAuthentication
           headers = headers.merge(handler.handleHeader)
         elsif handler.kind_of? Mashape::QueryAuthentication
           parameters = parameters.merge(handler.handleParams)
         elsif handler.kind_of? Mashape::OAuth10aAuthentication
           if url.end_with?("/oauth_url") == false && (handler.handleParams[:access_token] == nil || handler.handleParams[:access_secret] == nil)
             raise Mashape::JsonException.new("Before consuming OAuth endpoint, invoke authorize('access_token','access_secret') with not null values")
           end
           # These headers will be processed by the proxy to sign the request
           headers["x-mashape-oauth-consumerkey"] = handler.handleParams[:consumer_key]
           headers["x-mashape-oauth-consumersecret"] = handler.handleParams[:consumer_secret]
           headers["x-mashape-oauth-accesstoken"] = handler.handleParams[:access_token]
           headers["x-mashape-oauth-accesssecret"] = handler.handleParams[:access_secret]
         elsif handler.kind_of? Mashape::OAuth2Authentication
           if url.end_with?("/oauth_url") == false && handler.handleParams[:access_token] == nil
              raise Mashape::JsonException.new("Before consuming OAuth endpoint, invoke authorize('access_token') with a not null value")
           end
           parameters = parameters.merge({"access_token" => handler.handleParams[:access_token]})
         end
         
       end
       
       Mashape::HttpUtils.setRequestHeaders(content_type, response_type, headers)
       
       if(content_type == :json)
         unless parameters[:json_param_body] == nil
           parameters = JSON(parameters[:json_param_body])
         else
           parameters = {}
         end
       end
       
       begin
        case method
          when :get
            uri = Addressable::URI.new
            uri.query_values = parameters
            httpResponse = RestClient.get url + "?" + uri.query, headers
          when :post
            httpResponse = RestClient.post url, parameters, headers
          when :put
            httpResponse = RestClient.put url, parameters, headers
          when :delete
            httpResponse = RestClient.delete url, parameters, headers
          when :patch
            httpResponse = RestClient.patch url, parameters, headers
        end
        rescue => e
          httpResponse = e.response
        end
        
        response = HttpResponse.new
        response.code = httpResponse.code
        response.headers = httpResponse.headers
        response.raw_body = httpResponse
        
        Mashape::HttpUtils.setResponse(response_type, response)
        
        return response
    end
  end
end
