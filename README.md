# Unirest for Ruby [![Build Status](https://api.travis-ci.org/Mashape/unirest-ruby.png)](https://travis-ci.org/Mashape/unirest-ruby)

Unirest is a set of lightweight HTTP libraries available in multiple languages, ideal for most applications:

* Make `GET`, `POST`, `PUT`, `PATCH`, `DELETE` requests
* Both syncronous and asynchronous (non-blocking) requests
* It supports form parameters, file uploads and custom body entities
* Supports gzip
* Supports Basic Authentication natively
* Customizable timeout
* Customizable default headers for every request (DRY)
* Automatic JSON parsing into a native object for JSON responses

Created with love by [thefosk](https://github.com/thefosk) @ [mashape.com](https://mashape.com)

## Installing

Requirements: **Ruby >= 2.0**

To utilize unirest, install the `unirest` gem:

```
gem install unirest
```

After installing the gem package you can now begin to simplifying requests by requiring `unirest`:

```ruby
require 'unirest'
```

## Creating Requests

So you're probably wondering how using Unirest makes creating requests in Ruby easier, let's start with a working example:

```ruby
response = Unirest.post "http://httpbin.org/post", 
                        headers:{ "Accept" => "application/json" }, 
                        parameters:{ :age => 23, :foo => "bar" }

response.code # Status code
response.headers # Response headers
response.body # Parsed body
response.raw_body # Unparsed body
```

## Asynchronous Requests
Unirest-Ruby also supports asynchronous requests with a callback function specified inside a block, like:

```ruby
response = Unirest.post "http://httpbin.org/post", 
                        headers:{ "Accept" => "application/json" }, 
                        parameters:{ :age => 23, :foo => "bar" } {|response|
	response.code # Status code
	response.headers # Response headers
	response.body # Parsed body
	response.raw_body # Unparsed body
}
```

## File Uploads
```ruby
response = Unirest.post "http://httpbin.org/post", 
                        headers:{ "Accept" => "application/json" }, 
                        parameters:{ :age => 23, :file => File.new("/path/to/file", 'rb') }
```
 
## Custom Entity Body
```ruby
response = Unirest.post "http://httpbin.org/post", 
                        headers:{ "Accept" => "application/json" }, 
                        parameters:{ :age => "value", :foo => "bar" }.to_json # Converting the Hash to a JSON string
```

### Basic Authentication

Authenticating the request with basic authentication can be done by providing an `auth` Hash with `:user` and `:password` keys like:

```ruby
response = Unirest.get "http://httpbin.org/get", auth:{:user=>"username", :password=>"password"}
```

# Request
```ruby
Unirest.get(url, headers: {}, parameters: nil, auth:nil, &callback)
Unirest.post(url, headers: {}, parameters: nil, auth:nil, &callback)
Unirest.delete(url, headers: {}, parameters: nil, auth:nil, &callback)
Unirest.put(url, headers: {}, parameters: nil, auth:nil, &callback)
Unirest.patch(url, headers: {}, parameters: nil, auth:nil, &callback)
```
  
- `url` (`String`) - Endpoint, address, or uri to be acted upon and requested information from.
- `headers` (`Object`) - Request Headers as associative array or object
- `parameters` (`Array` | `Object` | `String`) - Request Body associative array or object
- `callback` (`Function`) - _Optional_; Asychronous callback method to be invoked upon result.

# Response
Upon receiving a response Unirest returns the result in the form of an Object, this object should always have the same keys for each language regarding to the response details.

- `code` - HTTP Response Status Code (Example `200`)
- `headers` - HTTP Response Headers
- `body` - Parsed response body where applicable, for example JSON responses are parsed to Objects / Associative Arrays.
- `raw_body` - Un-parsed response body

# Advanced Configuration

You can set some advanced configuration to tune Unirest-Ruby:

### Timeout

You can set a custom timeout value (in **seconds**):

```ruby
Unirest.timeout(5) # 5s timeout
```

### Default Request Headers

You can set default headers that will be sent on every request:

```ruby
Unirest.default_header('Header1','Value1')
Unirest.default_header('Header2','Value2')
```

You can clear the default headers anytime with:

```ruby
Unirest.clear_default_headers()
```



