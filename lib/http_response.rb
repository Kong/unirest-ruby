require 'json'

module MashapeRest
  
  class HttpResponse
    attr_reader :code
    attr_reader :raw_body  
    attr_reader :body
    attr_reader :headers
    
    def initialize(http_response)
      @code = http_response.code;
      @headers = http_response.headers
      @raw_body = http_response
      @body = @raw_body
      
      begin
        @body = JSON.parse(@raw_body)
      rescue Exception
      end
      
    end
    
  end
  
end