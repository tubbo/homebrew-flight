# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flight/version'

Gem::Specification.new do |spec|
  spec.name          = "flight"
  spec.version       = Flight::VERSION
  spec.authors       = ["Tom Scott"]
  spec.email         = ["tscott@weblinc.com"]

  spec.summary       = "Flight is a Bundler for Homebrew."
  spec.description   = "#{spec.summary} It keeps your packages up to date."
  spec.homepage      = "https://github.com/tubbo/flight"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10"
  spec.add_development_dependency "rspec", "~> 3"

  spec.add_dependency "rspec"
end
