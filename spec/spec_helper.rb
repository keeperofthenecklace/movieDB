$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib/', __FILE__)
require 'movieDB'
require 'MovieDB/base'
require "MovieDB/person"
require 'MovieDB/status_checker'
require 'MovieDB/movie_error'
require "MovieDB/data_process"
require "MovieDB/data_export"

RSpec.configure do |config|
#  config.include SimpleBdd
end
