# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pyrosome/version'

Gem::Specification.new do |spec|
  spec.name          = "pyrosome"
  spec.version       = Pyrosome::VERSION
  spec.authors       = ["Brian Underwood"]
  spec.email         = ["ml+github@semi-sentient.com"]

  spec.summary       = %q{Helper to process different types of files (JSON, CSV, etc..) line-by-line from the command line}
  spec.homepage      = "https://github.com/cheerfulstoic/pyrosome"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'yajl-ruby', '~> 1.2.1'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
