# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 's2_netbox/version'

Gem::Specification.new do |spec|
  spec.name          = 's2_netbox'
  spec.version       = S2Netbox::VERSION
  spec.authors       = ['Teamsquare']
  spec.email         = ['hello@teamsquare.co']

  spec.summary       = %q{Ruby wrapper for S2 NetBox API.}
  spec.description   = %q{S2 is an enterprise class, feature-rich web-based access control and event monitoring system. This Ruby wrapper makes integrating with the API on NetBox controllers easy. See http://s2sys.com/ for more information.}
  spec.homepage      = 'https://github.com/teamsquare/s2_netbox'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '~> 0.14'
  spec.add_runtime_dependency 'activesupport', '~> 4.0'
  spec.add_runtime_dependency 'facets', '~> 3.1'

  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter', '0.2.2'
  spec.add_development_dependency 'simplecov', '~> 0.7.1'
  spec.add_development_dependency 'webmock', '~> 2.1'
  spec.add_development_dependency 'factory_girl', '~> 4.7'
  spec.add_development_dependency 'codeclimate-test-reporter', '~> 1.0'
end