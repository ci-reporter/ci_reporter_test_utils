# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ci/reporter/test_utils/version'

Gem::Specification.new do |spec|
  spec.name          = "ci_reporter_test_utils"
  spec.version       = CI::Reporter::TestUtils::VERSION
  spec.authors       = ["Nick Sieger", "Jake Goulding"]
  spec.email         = ["nick@nicksieger.com", "jake.goulding@gmail.com"]
  spec.summary       = %q{Test utilities for CI::Reporter}
  spec.homepage      = "https://github.com/ci-reporter/ci_reporter_test_utils"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
