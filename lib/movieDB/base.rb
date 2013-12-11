require 'rubygems'
require 'MovieDB/status_checker'
require 'MovieDB/movie_error'

module MovieDB #:nodoc
# MoviesDB v0.1.x is not a datastore gem. Rather is performs mathematical computations for analyzing film data from imdb.  can manage the data store of pre-production, production and final film releases.
# Its a solution to the common problem of building a multi-database that utilizes both SQL and NoSQL
# combined features to increase speed and performance for reading records.
  class Base
    include StatusChecker
    include MovieError
  end
end
$:.unshift File.expand_path('..', __FILE__)
