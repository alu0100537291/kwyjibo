# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kwyjibo/version'

Gem::Specification.new do |spec|
  spec.name          = "kwyjibo"
  spec.version       = Kwyjibo::VERSION
  spec.authors       = ["José Alberto"]
  spec.email         = ["japmelian@gmail.com"]
  spec.description   = %q{CoAuthor: Jéssica Alejandra}
  spec.summary       = %q{LPP - Práctica 9}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec', '~> 2.9'
end
