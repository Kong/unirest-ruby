# Unirest for Ruby

Unirest is a set of lightweight HTTP libraries available in multiple languages.

Created with love by http://mashape.com



## Installing
To utilize unirest, install the `unirest` gem:

```
gem install unirest
```

After installing the gem package you can now begin to simplifying requests by requiring `unirest`:

```ruby
require 'unirest'
```

## Creating Request
So you're probably wondering how using Unirest makes creating requests in Ruby easier, let's start with a working example:

```ruby
response = Unirest.post "http://httpbin.org/post",
  { "Accept" => "application/json" },
  { :parameter => 23, :foo => "bar" }
```


## File Uploads
```ruby
response = Unirest.post "http://httpbin.org/post",
  { "Accept" => "application/json" },
  { :parameter => 23, :file => File.new("/path/to/file", 'rb') }
```
 
## Custom Entity Body
```ruby
response = Unirest.post "http://httpbin.org/post",
  { "Accept" => "application/json" },
  { :parameter => "value", :foo => "bar" }.to_json
```

# Request
```ruby
Unirest.get(url, headers = {}, &callback) 
Unirest.post(url, headers = {}, body = nil, &callback)
Unirest.put(url, headers = {}, body = nil, &callback)
Unirest.patch(url, headers = {}, body = nil, &callback)
Unirest.delete(url, headers = {}, &callback)
```
  
- `url` (`String`) - Endpoint, address, or uri to be acted upon and requested information from.
- `headers` (`Object`) - Request Headers as associative array or object
- `body` (`Array` | `Object` | `String`) - Request Body associative array or object
- `callback` (`Function`) - _Optional_; Asychronous callback method to be invoked upon result.

# Response
Upon receiving a response Unirest returns the result in the form of an Object, this object should always have the same keys for each language regarding to the response details.

- `code` - HTTP Response Status Code (Example `200`)
- `headers` - HTTP Response Headers
- `body` - Parsed response body where applicable, for example JSON responses are parsed to Objects / Associative Arrays.
- `raw_body` - Un-parsed response body
