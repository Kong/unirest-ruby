require 'net/http'
require 'net/https'
require 'rubygems'
require 'json'
require File.join(File.dirname(__FILE__), "/../exceptions/mashape_client_exception.rb")
require File.join(File.dirname(__FILE__), "/url_utils.rb")

module MashapeClient
  module HTTP
    
    # Removes "warning: peer certificate won't be verified in this SSL session"
    class Net::HTTP
      alias_method :old_initialize, :initialize
      def initialize(*args)
        old_initialize(*args)
        @ssl_context = OpenSSL::SSL::SSLContext.new
        @ssl_context.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
    end
    
    class HttpClient
      
      def HttpClient.do_request(method, url, parameters, token, &callback)
        if callback
          return Thread.new do
            response = self.exec_request(method, url, parameters, token)
            callback.call(response)
          end
        else
          return exec_request(method, url, parameters, token)
        end
      end
      
      def HttpClient.exec_request(method, url, parameters, token)
        
        url, parameters = MashapeClient::HTTP::UrlUtils.add_client_parameters(url, parameters, token)
        url, parameters = MashapeClient::HTTP::UrlUtils.prepare_request(url, parameters, (method == :get) ? false : true)
        
        uri = URI.parse(url);
        http = Net::HTTP.new(uri.host, uri.port)
        if uri.port == 443
          http.use_ssl = true
        end
        
        request = nil   
        
        case method
          when :get
          request = Net::HTTP::Get.new(uri.request_uri) 
          when :post
          request = Net::HTTP::Post.new(uri.request_uri)
          when :put
          request = Net::HTTP::Put.new(uri.request_uri)
          when :delete
          request = Net::HTTP::Delete.new(uri.request_uri)
        else
          raise MashapeClient::Exceptions::MashapeClientException.new(MashapeClient::Exceptions::EXCEPTION_NOTSUPPORTED_HTTPMETHOD, MashapeClient::Exceptions::EXCEPTION_NOTSUPPORTED_HTTPMETHOD_CODE)
        end
        
        unless method == :get 
          request.set_form_data(parameters)
        end
        
        response = http.request(request).body
        
        json_response = nil;
        
        begin
          json_response = JSON.parse(response)
        rescue StandardError
          raise MashapeClient::Exceptions::MashapeClientException.new(MashapeClient::Exceptions::EXCEPTION_INVALID_REQUEST % response, MashapeClient::Exceptions::EXCEPTION_SYSTEM_ERROR_CODE)
        end
        
        return json_response
        
      end
    end
  end
end
