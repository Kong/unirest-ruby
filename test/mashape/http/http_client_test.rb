require 'test/unit'
require File.join(File.dirname(__FILE__), "/../../../main/mashape/http/http_client.rb")

class StringTest < Test::Unit::TestCase
  
  def ciao(response)
    puts "cazzi"
  end
  
  def test_do_request
    assert_raise (MashapeClient::Exceptions::MashapeClientException) {   
      MashapeClient::HTTP::HttpClient.do_request(:pippo, "http://www.ciao.com", nil, nil)
    }
    assert_raise (MashapeClient::Exceptions::MashapeClientException) {
      MashapeClient::HTTP::HttpClient.do_request(:get, "http://www.google.com", nil, nil)
    }
    
    response = MashapeClient::HTTP::HttpClient.do_request(:post, "https://api.mashape.com/requestToken", nil, nil)
    assert_not_nil(response)
    assert_equal(2001, response["errors"][0]["code"])
    
    threads = []
    
    threads << MashapeClient::HTTP::HttpClient.do_request(:post, "https://api.mashape.com/requestToken", nil, nil) { |res| 
      assert_not_nil(res)
      assert_equal(2001, res["errors"][0]["code"])
    }
    
    threads << MashapeClient::HTTP::HttpClient.do_request(:post, "http://127.0.0.1/php/api.php", nil, nil) { |res| 
      assert_not_nil(res)
    }
    
    threads.each { |aThread|  aThread.join }
    
  end  
  
end
