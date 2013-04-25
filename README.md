Unirest-Ruby
============================================

Unirest is a set of lightweight HTTP libraries available in PHP, Ruby, Python, Java, Objective-C.

Documentation
-------------------

### Installing
To utilize unirest, install the `unirest` gem:

```
gem install unirest
```

After installing the gem package you can now begin to simplifying requests by requiring `unirest`:

```ruby
require 'unirest'
```

### Creating Request
So you're probably wondering how using Unirest makes creating requests in Ruby easier, let's start with a working example:

```ruby
response = Unirest::post "http://httpbin.org/post",
  { "Accept" => "application/json" },
  {
    :parameter => 23,
    :foo => "bar"
  }
```


### File Uploads
```ruby
response = Unirest::post "http://httpbin.org/post",
  { "Accept" => "application/json" },
  {
    :parameter => 23,
    :file => File.new("/path/to/file", 'rb')
  }
```
 
### Custom Entity Body
```ruby
response = Unirest::post "http://httpbin.org/post",
  { "Accept" => "application/json" },
  {
    :parameter => "value",
    :foo => "bar"
  }.to_json
```

### Request Reference
```ruby
Unirest::get(url, headers = {}, &callback) 
Unirest::post(url, headers = {}, body = nil, &callback)
Unirest::put(url, headers = {}, body = nil, &callback)
Unirest::patch(url, headers = {}, body = nil, &callback)
Unirest::delete(url, headers = {}, &callback)
```
  
`url`
Endpoint, address, or uri to be acted upon and requested information from.

`headers`
Request Headers as associative array or object

`body`
Request Body associative array or object

`callback`
Asychronous callback method to be invoked upon result.

### Response Reference
Upon recieving a response Unirest returns the result in the form of an Object, this object should always have the same keys for each language regarding to the response details.

`code`
HTTP Response Status Code (Example `200`)

`headers`
HTTP Response Headers

`body`
Parsed response body where applicable, for example JSON responses are parsed to Objects / Associative Arrays.

`raw_body`
Un-parsed response body
License
---------------

The MIT License

Copyright (c) 2013 Mashape (http://mashape.com)

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
