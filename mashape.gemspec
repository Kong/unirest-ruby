Gem::Specification.new do |s|
  s.name        = 'mashape'
  s.version     = '2.0.4'
  s.date        = Date.today.to_s
  s.summary     = "The Mashape Ruby client library"
  s.description = "The Mashape Ruby client library needed to consume APIs on Mashape"
  s.authors     = ["Mashape"]
  s.email       = 'support@mashape.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    =
    'https://www.mashape.com'
    
  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "addressable"
  s.add_runtime_dependency "ruby-hmac"

end
