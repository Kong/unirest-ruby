Gem::Specification.new do |s|
  s.name        = 'unicorn-rest'
  s.version     = '1.0.6'
  s.date        = Date.today.to_s
  s.summary     = "Unicorn, the lightweight HTTP library"
  s.description = "Unicorn is a set of lightweight HTTP libraries available in PHP, Ruby, Python, Java, Objective-C."
  s.authors     = ["Mashape"]
  s.email       = 'support@mashape.com'
  s.files       = Dir['lib/**/*.rb']

  s.homepage    =
    'https://www.mashape.com'
    
  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "json"
  s.add_runtime_dependency "addressable"

end
