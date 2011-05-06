#--
# Mashape Ruby Client library.
#
# Copyright (C) 2011 Mashape, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
#
# The author of this software is Mashape, Inc.
# For any question or feedback please contact us at: support@mashape.com
#++

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
