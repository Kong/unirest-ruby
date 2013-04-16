Unicorn-Ruby
============================================

Unicorn is a set of lightweight HTTP libraries available in PHP, Ruby, Python, Java, Objective-C.

Documentation
-------------------

### Installing
To utilize unicorn, install the `unicorn-rest` gem:

    gem install unicorn-rest

After installing the gem package you can now begin to simplifying requests by requiring `unicorn-rest`:

    require 'unicorn-rest'


### Creating Request
So you're probably wondering how using Unicorn makes creating requests in Ruby easier, let's start with a working example:


    response = UnicornRest::post "http://httpbin.org/post",
      { "Accept" => "application/json" },
      {
        :parameter => 23,
        :foo => "bar"
      }


### File Uploads
    response = UnicornRest::post "http://httpbin.org/post",
      { "Accept" => "application/json" },
      {
        :parameter => 23,
        :foo => "bar"
      }
 
### Custom Entity Body
    response = UnicornRest::post "http://httpbin.org/post",
      { "Accept" => "application/json" },
      {
        :parameter => "value",
        :foo => "bar"
      }.to_json

### Request Reference
    UnicornRest::get(url, headers = {}, &callback) 
    UnicornRest::post(url, headers = {}, body = nil, &callback)
    UnicornRest::put(url, headers = {}, body = nil, &callback)
    UnicornRest::patch(url, headers = {}, body = nil, &callback)
    UnicornRest::delete(url, headers = {}, &callback)
  
`url`
Endpoint, address, or uri to be acted upon and requested information from.

`headers`
Request Headers as associative array or object

`body`
Request Body associative array or object

`callback`
Asychronous callback method to be invoked upon result.

### Response Reference
Upon recieving a response Unicorn returns the result in the form of an Object, this object should always have the same keys for each language regarding to the response details.

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
