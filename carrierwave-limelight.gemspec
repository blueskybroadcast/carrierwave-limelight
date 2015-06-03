# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carrierwave/limelight/version'

Gem::Specification.new do |spec|
  spec.name          = "carrierwave-limelight"
  spec.version       = Carrierwave::Limelight::VERSION
  spec.authors       = ["Viktor Leonets"]
  spec.email         = ["4405511@gmail.com"]
  spec.summary       = %q{carrierwave limelight}
  spec.description   = %q{carrierwave limelight}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'rest-client'
  spec.add_runtime_dependency 'streamio-ffmpeg'
  spec.add_runtime_dependency 'carrierwave'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry-byebug"
end
