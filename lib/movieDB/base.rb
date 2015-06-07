require 'rubygems'
require 'MovieDB/status_checker'
require 'MovieDB/movie_error'

module MovieDB #:nodoc
# MoviesDB is not a datastore gem. Rather, it is a high-level statistical software that performs
# mathematical computations for analyzing film data from imdb.
# It is a solution to the common problem of deducing logical hypothesis based off movie data.
  class Base
    include StatusChecker
    include MovieError
  end
end
$:.unshift File.expand_path('..', __FILE__)

