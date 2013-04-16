# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'redisable/version'

Gem::Specification.new do |spec|
  spec.name          = "redisable"
  spec.version       = Redisable::VERSION
  spec.authors       = ["yoppi"]
  spec.email         = ["y.hirokazu@gmail.com"]
  spec.description   = %q{Thin wrapper library for Redis, enable any Ruby class to access Redis.}
  spec.summary       = %q{Thin wrapper library for Redis.}
  spec.homepage      = "http://github.com/yoppi/redisable"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "redis"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
