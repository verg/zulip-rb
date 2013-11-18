# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zulip/version'

Gem::Specification.new do |spec|
  spec.name          = "zulip-rb"
  spec.version       = Zulip::VERSION
  spec.authors       = ["Ryan Vergeront"]
  spec.email         = ["ryan.vergeront@gmail.com"]
  spec.description   = %q{A ruby wrapper for the Zulip API.}
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/verg/zulip-rb"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
