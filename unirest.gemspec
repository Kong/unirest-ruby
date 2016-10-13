Gem::Specification.new do |s|
  s.name        = 'unirest'
  s.version     = '1.1.2'
  s.summary     = "Unirest-Ruby"
  s.description = "Simplified, lightweight HTTP client library"
  s.authors     = ["Mashape"]
  s.email       = 'opensource@mashape.com'
  s.homepage    = 'https://github.com/Mashape/unirest-ruby'
  s.license     = 'MIT'

  s.add_dependency('rest-client', '~> 1.8.0')
  s.add_dependency('json', '~> 1.8.1')
  s.add_dependency('addressable', '~> 2.3.5')

  s.add_development_dependency('shoulda', '~> 3.5.0')
  s.add_development_dependency('test-unit')
  s.add_development_dependency('rake')

  s.required_ruby_version = '~> 2.0'

  s.files       = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ['lib']

end
