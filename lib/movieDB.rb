require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'MovieDB/data_store'
require 'MovieDB/base'
# require "MovieDB/relation/query_methods"
load '/Users/albertmckeever/Sites/movieDB/lib/movieDB/relation/query_methods.rb'
# require 'MovieDB/data_analysis/statistics'
load '/Users/albertmckeever/Sites/movieDB/lib/movieDB/data_analysis/statistics.rb'


module MovieDB

  # Create a new movie record. The values are stored in the key-value data store.
  #
  # Default values are supplement during the instantiation of the class.
  # Those values are overridden when you provide one.
  #
  # You can use it like this:
  #
  #   movie = Movie.new()
  #   movie.title = "When Sally Met Harry"
  #
  # You can raise a MovieError like this:
  #
  class Movie < MovieDB::Base

    include MovieDB::Relation::QueryMethods
    include MovieDB::DataAnalysis::Statistics

    def ids_to_array(ids)
      arr ||= []

      if ids.is_a? String
        arr << ids
      end

      if ids.is_a? Numeric
        arr << ids.to_s
      end

      if ids.is_a? Array
        ids.each do |n|
          arr << n.to_s
        end
      end

      return arr.flatten
    end
  end
end


