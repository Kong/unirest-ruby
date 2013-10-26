require 'rubygems'
require 'minitest/spec'
require 'minitest/autorun'
require 'rest-client'

require File.expand_path(File.join(File.dirname(__FILE__), '../lib/unirest'))

describe Unirest::HttpRequest do
  it "handles invalids URLs" do
    lambda { Unirest::HttpRequest.new(:get, 'invalid-url') }.must_raise(RuntimeError)
  end

  it "downcases header keys" do
    request = Unirest::HttpRequest.new(:post, 'http://example.com', {'ACCEPT' => 'text/xml'}, '')
    request.headers['accept'].must_equal 'text/xml'
  end

  it "escapes url" do
    request = Unirest::HttpRequest.new(:get, 'http://example.com/?q=search query')
    request.url.must_equal 'http://example.com/?q=search%20query'
  end

  it "encapsulates data" do
    request = Unirest::HttpRequest.new(:post, 'http://example.com', {'Accept' => 'application/json'}, 'k1=v1&k2=v2')
    request.method.must_equal :post
    request.url.must_equal 'http://example.com'
    request.headers.must_equal 'accept' => 'application/json'
    request.body.must_equal 'k1=v1&k2=v2'
  end

  it "adds headers" do
    request = Unirest::HttpRequest.new(:post, 'http://example.com', {'from' => 'john@example.com'}, '')
    request.add_header('Accept', 'application/json')
    request.headers.must_equal 'Accept' => 'application/json', 'from' => 'john@example.com'
  end
end

describe Unirest::HttpResponse do
  it "encapsulates data" do
    raw_response = Net::HTTPResponse.new('1.1', '200', 'okay')
    rest_response = RestClient::Response.create('okay', raw_response, {})
    response = Unirest::HttpResponse.new(rest_response)
    response.code.must_equal 200
    response.raw_body.must_equal 'okay'
    response.body.must_equal 'okay'
    response.headers.must_equal({})
  end

  it "parses JSON" do
    raw_response = Net::HTTPResponse.new('1.1', '200', '')
    rest_response = RestClient::Response.create('{"key":"value"}', raw_response, {})
    response = Unirest::HttpResponse.new(rest_response)
    response.raw_body.must_equal '{"key":"value"}'
    response.body.must_equal 'key' => 'value'
  end
end
