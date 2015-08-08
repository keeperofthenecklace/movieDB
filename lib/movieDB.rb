require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'MovieDB/data_store'
require 'MovieDB/base'
require 'MovieDB/relation/print_methods'
# require "MovieDB/relation/query_methods"
load '/Users/albertmckeever/Sites/movieDB/lib/movieDB/relation/query_methods.rb'
# require 'MovieDB/data_analysis'
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
    include MovieDB::Relation::PrintMethods
    include MovieDB::DataAnalysis::Statistics

    def ids_to_array(ids)
      arr ||= []

      if ids.is_a? Array
        ids.each do |n|
          arr << n.to_s
        end
      end

      if ids.is_a? String
        arr << ids
      end

      if ids.is_a? Numeric
        arr << ids.to_s
      end

      return arr.flatten
    end
  end
end

m =  MovieDB::Movie.new
m.fetch("0369610", "3079380","0478970")
# m.all_ids

# p m.hgetall("3079380")
# p m.hkeys("0369610")
#  m.hvals("3155320")

# m.correlation only: [:revenue, :title]
# m.correlation only: [:revenue, :title]
# m.correlation except: [:revenue, :title]
p m.std only: [:budget, :revenue, :length, :vote_average]
# p m.worksheet
# p m.std #only: [:title, :budget, :revenue, :length, :vote_average]


# m.delete_all


