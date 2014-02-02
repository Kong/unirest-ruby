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

require_relative '../lib/unirest'
require 'test/unit'
require 'shoulda'

module Unirest
  class RequestsTest < Test::Unit::TestCase

    should "GET" do
      
      response = Unirest.get("http://httpbin.org/get?name=Mark", parameters:{'nick'=> "sinz s"})
      assert response.code == 200

      args = response.body['args']
      assert args.length == 2
      assert args['name'] == 'Mark'
      assert args['nick'] == 'sinz s'

    end

    should "POST" do
      
      response = Unirest.post("http://httpbin.org/post", parameters:{'name' => 'Mark', 'nick'=> "sinz s"})
      assert response.code == 200

      args = response.body['form']
      assert args.length == 2
      assert args['name'] == 'Mark'
      assert args['nick'] == 'sinz s'

    end

    should "POST custom body" do
      
      response = Unirest.post("http://httpbin.org/post", parameters:"hello")
      assert response.code == 200

      data = response.body['data']
      assert data == "hello"

    end

    should "PUT" do
      
      response = Unirest.put("http://httpbin.org/put", parameters:{'name' => 'Mark', 'nick'=> "sinz s"})
      assert response.code == 200

      args = response.body['form']
      assert args.length == 2
      assert args['name'] == 'Mark'
      assert args['nick'] == 'sinz s'

    end

    should "PATCH" do
      
      response = Unirest.patch("http://httpbin.org/patch", parameters:{'name' => 'Mark', 'nick'=> "sinz s"})
      assert response.code == 200

      args = response.body['form']
      assert args.length == 2
      assert args['name'] == 'Mark'
      assert args['nick'] == 'sinz s'

    end

    should "DELETE" do
      
      response = Unirest.delete("http://httpbin.org/delete", parameters:{'name' => 'Mark', 'nick'=> "sinz s"})
      assert response.code == 200

      data = response.body['data']
      assert data == "name=Mark&nick=sinz%20s"

    end

    should "GET ASYNC" do
      
      executed = false;

      thread = Unirest.get("http://httpbin.org/get?name=Mark", parameters:{'nick'=> "sinz s"}) {|response|
        assert response.code == 200
        executed = true
      }

      assert thread != nil
      assert executed == false
      thread.join()
      assert executed == true

    end

    should "gzip" do
      
      response = Unirest.get("http://httpbin.org/gzip")
      assert response.code == 200

      assert response.body['gzipped'] == true

    end

    should "Basic Authentication" do

      response = Unirest.get("http://httpbin.org/get?name=Mark", parameters:{'nick'=> "sinz s"}, auth:{:user=>"marco", :password=>"password"})
      assert response.code == 200

      headers = response.body['headers']
      assert headers['Authorization'] == "Basic bWFyY286cGFzc3dvcmQ="

    end

    should "Timeout" do
      
      Unirest.timeout(1);
      begin
        response = Unirest.get("http://httpbin.org/delay/3")
      rescue RuntimeError
        # Ok
      end

      Unirest.timeout(3);
      response = Unirest.get("http://httpbin.org/delay/1")
      assert response.code == 200
    end

    should "Throw underlying error" do

      begin
        Unirest.get("http://bad.domain.test")
      rescue => e
        assert ! e.is_a?(NoMethodError)
      end
    end

    should "Default Headers" do

      Unirest.default_header('Hello','test')

      response = Unirest.get("http://httpbin.org/get")
      assert response.code == 200

      headers = response.body['headers']
      assert headers['Hello'] == "test"

      response = Unirest.get("http://httpbin.org/get")
      assert response.code == 200

      headers = response.body['headers']
      assert headers['Hello'] == "test"

      Unirest.clear_default_headers()

      response = Unirest.get("http://httpbin.org/get")
      assert response.code == 200

      headers = response.body['headers']
      assert headers['Hello'] == nil

    end

  end
end