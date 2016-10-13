# Unirest for Ruby [![Build Status][travis-image]][travis-url] [![version][gem-version]][gem-url]

[![License][license-image]][license-url]
[![Downloads][gem-downloads]][gem-url]
[![Code Climate][codeclimate-quality]][codeclimate-url]
[![Gitter][gitter-image]][gitter-url]

![][unirest-logo]


[Unirest](http://unirest.io) is a set of lightweight HTTP libraries available in multiple languages, built and maintained by [Mashape](https://github.com/Mashape), who also maintain the open-source API Gateway [Kong](https://github.com/Mashape/kong). 

## Features

* Make `GET`, `POST`, `PUT`, `PATCH`, `DELETE` requests
* Both syncronous and asynchronous (non-blocking) requests
* Supports form parameters, file uploads and custom body entities
* Supports gzip
* Supports Basic Authentication natively
* Customizable timeout
* Customizable default headers for every request (DRY)
* Automatic JSON parsing into a native object for JSON responses

## Installing

Requirements: **Ruby >= 2.0**

To utilize unirest, install the `unirest` gem:

```bash
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

### User-Agent

The default User-Agent string is `unirest-ruby/1.1`. You can customize
it like this:

```ruby
Unirest.user_agent("custom_user_agent")
```

----

Made with &#9829; from the [Mashape](https://www.mashape.com/) team

[unirest-logo]: http://cl.ly/image/2P373Y090s2O/Image%202015-10-12%20at%209.48.06%20PM.png


[license-url]: https://github.com/Mashape/unirest-ruby/blob/master/LICENSE
[license-image]: https://img.shields.io/badge/license-MIT-blue.svg?style=flat

[gitter-url]: https://gitter.im/Mashape/unirest-ruby
[gitter-image]: https://img.shields.io/badge/Gitter-Join%20Chat-blue.svg?style=flat

[travis-url]: https://travis-ci.org/Mashape/unirest-ruby
[travis-image]: https://img.shields.io/travis/Mashape/unirest-ruby.svg?style=flat

[gem-url]: https://rubygems.org/gems/unirest
[gem-version]: https://img.shields.io/gem/v/unirest.svg?style=flat
[gem-downloads]: https://img.shields.io/gem/dt/unirest.svg?style=flat

[codeclimate-url]: https://codeclimate.com/github/Mashape/unirest-ruby
[codeclimate-quality]: https://img.shields.io/codeclimate/github/Mashape/unirest-ruby.svg?style=flat
[codeclimate-coverage]: https://img.shields.io/codeclimate/coverage/github/Mashape/unirest-ruby.svg?style=flat

[versioneye-url]: https://www.versioneye.com/user/projects/x
[versioneye-image]: https://img.shields.io/versioneye/d/user/projects/x.svg?style=flat
