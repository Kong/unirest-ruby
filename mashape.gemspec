Gem::Specification.new do |s|
  s.name        = 'mashape'
  s.version     = '3.0.0'
  s.date        = Date.today.to_s
  s.summary     = "The Mashape REST client library"
  s.description = "The Mashape REST client library"
  s.authors     = ["Mashape"]
  s.email       = 'support@mashape.com'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    =
    'https://www.mashape.com'
    
  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "addressable"

end
