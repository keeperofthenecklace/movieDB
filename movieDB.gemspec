# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'movieDB/version'

Gem::Specification.new do |spec|
  spec.name          = "movieDB"
  spec.version       = MovieDB::VERSION
  spec.authors       = ["Albert McKeever"]
  spec.email         = ["kotn_ep1@hotmail.com"]
  spec.description   = %q{Perform Data Analysis on IMDB Movies}
  spec.summary       = %q{Movie / TV Statistic and Data Analysis Tool}
  spec.homepage      = "https://github.com/keeperofthenecklace/movieDB"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency 'rake'
  spec.add_dependency 'themoviedb', "~> 0.1.0"
  spec.add_dependency 'redis'
  spec.add_dependency 'statsample'
  spec.add_dependency 'imdb'
  spec.add_dependency 'json'
  spec.add_dependency 'celluloid'
end
