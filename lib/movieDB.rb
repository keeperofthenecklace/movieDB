require "rubygems"
require "open-uri"                # is an easy-to-use wrapper for net/http, net/https and net/ftp.
require "nokogiri"                # is an HTML, XML, SAX, and Reader parser.
require "MovieDB/data_analysis"
require "MovieDB/data_store"
require "MovieDB/data_process"
require "MovieDB/base"
require "MovieDB/relation/print_methods"
require "MovieDB/relation/query_methods"



unless defined? MovieDB::Movie
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
      extend MovieDB::Secret::Lock

      include MovieDB::DataProcess
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
end

m = MovieDB::Movie.new
ids = [ "3079380", "0369610", "0133093"]
m.imdb_id = ids
# m.delete_all
m.all_ids
# m.keys
# m.pretty_json
# m.select(attr: ["title", "revenue"], ids: ['0120338', '2488496'] )