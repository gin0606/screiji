# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'screiji/version'

Gem::Specification.new do |spec|
  spec.name          = "screiji"
  spec.version       = Screiji::VERSION
  spec.authors       = ["gin0606"]
  spec.email         = ["kkgn06@gmail.com"]

  spec.summary       = "Generate example json from json schema"
  spec.description   = "Generate example json from json schema"
  spec.homepage      = "https://github.com/gin0606/screiji"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec"
end
