# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jarvis/version'

Gem::Specification.new do |spec|
  spec.name          = "jarvis-cli"
  spec.version       = Jarvis::VERSION
  spec.authors       = ["DVG"]
  spec.email         = ["bradley.temple@gmail.com"]
  spec.summary       = %q{Modular Slackbot Framework}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "byebug"
  spec.add_dependency "sinatra"
  spec.add_dependency "sinatra-contrib"
  spec.add_dependency "httparty"
  spec.add_dependency "thor"
  spec.add_dependency "activesupport"
  spec.add_dependency "hooks"
end
