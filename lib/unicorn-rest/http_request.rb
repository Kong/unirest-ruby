require 'addressable/uri'

module UnicornRest
  
  class HttpRequest
    attr_reader :method
    attr_reader :url 
    attr_reader :headers
    attr_reader :body
    
    def add_header(name, value)
      @headers[name] = value
    end
    
    def initialize(method, url, headers = {}, body = nil)
      @method = method
      
      unless url =~ URI::regexp
        raise "Invalid URL: " + url
      end
      
      @url = URI.escape(url)
      @headers = {}
      # Make the header key lowercase
      headers.each_pair {|key, value| @headers[key.downcase] = value }
      @body = body
    end
    
  end
  
end