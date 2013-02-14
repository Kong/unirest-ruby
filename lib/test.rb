require File.join(File.dirname(__FILE__), "/mashape_rest.rb")

puts MashapeRest.get("http://www.google.com")