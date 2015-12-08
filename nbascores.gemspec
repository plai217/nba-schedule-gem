# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nbascores/version'

Gem::Specification.new do |spec|
  spec.authors       = ["plai217"]
  spec.email         = ["philiplai217@gmail.com"]
  spec.description   = %q{nba scores and schedule cli}
  spec.summary       = %q{shows nba scores and schedule}
  spec.homepage      = "https://github.com/plai217"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = ["nbascores"]
  spec.name          = "nbascores"
  spec.require_paths = ["lib", "lib/nbascores"]
  spec.version       = Nbascores::VERSION
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'nokogiri'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "json"
  spec.add_development_dependency "open-uri"

end
