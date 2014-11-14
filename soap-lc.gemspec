# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'soap/lc/version'

Gem::Specification.new do |spec|
  spec.name          = "soap-lc"
  spec.version       = SOAP::LC::VERSION
  spec.authors       = ["glejeune"]
  spec.email         = ["gregoire.lejeune@free.fr"]
  spec.summary       = %q{SOAP Lite Client provides support for developing clients interfaces from WSDL files.}
  spec.description   = %q{SOAP Lite Client provides support for developing clients interfaces from WSDL files.}
  spec.homepage      = %q{http://github.com/glejeune/soap-lc}
  spec.license       = "GPL"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 0"
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
