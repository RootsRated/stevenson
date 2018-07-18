# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'stevenson/version'

Gem::Specification.new do |spec|
  spec.name          = "stevenson"
  spec.version       = Stevenson::VERSION
  spec.authors       = ["RootsRated"]
  spec.email         = ["developers@rootsrated.com"]
  spec.summary       = "Stevenson is a generator for Jekyll microsites created by RootsRated.com"
  spec.description   = "Stevenson is a simple generator for microsites using Jekyll"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency "cocaine", "~> 0.5"
  spec.add_dependency "git"
  spec.add_dependency "fog-aws", "~> 3.0"
  spec.add_dependency "hashie"
  spec.add_dependency "highline"
  spec.add_dependency "jekyll"
  spec.add_dependency "rubyzip", ">= 1.0.0"
  spec.add_dependency "thor"
end
