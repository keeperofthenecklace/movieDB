require "rubygems"
require "open-uri"
require "nokogiri"
require "MovieDB/data_store"
require "MovieDB/base"
require "MovieDB/relation/print_methods"
# require "MovieDB/relation/query_methods"
load "/Users/albertmckeever/Sites/movieDB/lib/movieDB/relation/query_methods.rb"


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

    # You can fetch IMDb movie data like this:
    #   ids = ["2024544", "1800241"]
    #
    #   m = MovieDB::Movie.new
    #   m.imdb_id = ids
    def imdb_id=(ids)
      @imdb_id = ids_to_array(ids)
      store_data(@imdb_id)
    end

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

m = MovieDB::Movie.new
m.imdb_id = ["0369610", "3079380"]
# m.imdb_id = ["ffffff610", "hhhhhh9380"]

 # m.delete_all
