Gem::Specification.new do |s|
  s.name        = 'unirest'
  s.version     = '1.1.2'
  s.summary     = "Unirest-Ruby"
  s.description = "Simplified, lightweight HTTP client library"
  s.authors     = ["Mashape"]
  s.email       = 'opensource@mashape.com'
  s.homepage    = 'https://github.com/Mashape/unirest-ruby'
  s.license     = 'MIT'

  s.add_dependency('rest-client', '~> 2.0')
  s.add_dependency('json', '~> 2.0')
  s.add_dependency('addressable', '~> 2.4')

  s.add_development_dependency('activesupport', '< 5.0.0')
  s.add_development_dependency('shoulda', '~> 3.5')
  s.add_development_dependency('test-unit', '~> 3.2')
  s.add_development_dependency('rake', '~> 11.3')

  s.required_ruby_version = '~> 2.0'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.require_paths = ['lib']
end
