require 'test/unit'
require File.join(File.dirname(__FILE__), "/../../../main/mashape/http/token_util.rb")

class StringTest < Test::Unit::TestCase
  
  def test_request_token
    assert_raise (MashapeClient::Exceptions::MashapeClientException) {
      MashapeClient::HTTP::TokenUtil.request_token(nil)
    }
    
    assert_raise (MashapeClient::Exceptions::MashapeClientException) {
      MashapeClient::HTTP::TokenUtil.request_token("")
    }
    
    assert_raise (MashapeClient::Exceptions::MashapeClientException) {
      MashapeClient::HTTP::TokenUtil.request_token("bla")
    }
  end
  
end
