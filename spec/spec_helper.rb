$TESTING = true

require "simplecov"
require "coveralls"
Coveralls.wear!

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter "/spec/"
  minimum_coverage(92.21)
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require "rspec"
require "imdb"
require "redis"
require 'fileutils'
require 'movieDB'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
RSpec::Expectations.configuration.warn_about_potential_false_positives = false
