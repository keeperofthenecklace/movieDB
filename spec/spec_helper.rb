$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib/', __FILE__)

require 'MovieDB/base'
require 'MovieDB/status_checker'
require 'MovieDB/movie_error'
require 'MovieDB/person'
require 'movieDB'

require 'simple_bdd'

RSpec.configure do |config|
  config.include SimpleBdd
end
