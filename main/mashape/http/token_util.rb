require File.join(File.dirname(__FILE__), "/http_client.rb")

module MashapeClient
  module HTTP
    class TokenUtil
      
      TOKEN_URL="https://api.mashape.com/requestToken"
      
      def TokenUtil.request_token(developer_key)
        
        parameters = {"devkey" => developer_key}
        json_response = MashapeClient::HTTP::HttpClient.do_request(:post, TOKEN_URL, parameters, nil);
        
        errors = json_response["errors"]
        if errors.empty?
          return json_response["token"]
        else
          raise MashapeClient::Exceptions::MashapeClientException.new(errors[0]["message"], errors[0]["code"])
        end
      end
      
    end
  end
end
