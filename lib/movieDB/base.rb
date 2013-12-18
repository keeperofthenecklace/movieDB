require 'rubygems'
require 'MovieDB/status_checker'
require 'MovieDB/movie_error'

module MovieDB #:nodoc
# MoviesDB v0.1.x is not a datastore gem. Rather, it is a high-level statistical sftware that performs
# mathematical computations for analyzing film data from imdb.  
# In a nut shell, it is a solution to the common problem of deducing logical hypothesis based off data sets.
  
  class Base
    include StatusChecker
    include MovieError
  end

end
$:.unshift File.expand_path('..', __FILE__)
