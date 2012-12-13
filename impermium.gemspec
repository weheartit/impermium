# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "impermium/version"

Gem::Specification.new do |s|
  s.name        = "impermium"
  s.version     = Impermium::VERSION
  s.platform    = Gem::Platform::RUBY
  s.date = Time.now.strftime('%Y-%m-%d')

  s.authors     = ["Juanjo Bazán", "Bosko Ivanisevic", "Neil Berkman", 'Antono Vasiljev']
  s.email       = ["jjbazan@gmail.com"]
  s.homepage    = "https://github.com/weheartit/impermium"
  s.summary     = "Impermium API wrapper"
  s.description = "Ruby wrapper for the Impermium social spam API"

  s.add_dependency "faraday_middleware", ">= 0.8.8"
  s.add_dependency "hashie", "~> 1.2.0"
  s.add_dependency "multi_json"

  s.add_development_dependency "rspec", "~> 2.8.0"
  s.add_development_dependency "webmock", "~> 1.8.1"
  s.add_development_dependency "vcr", "~> 2.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
