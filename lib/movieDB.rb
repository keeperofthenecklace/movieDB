require "rubygems"
require "open-uri"                # is an easy-to-use wrapper for net/http, net/https and net/ftp.
require "nokogiri"                # is an HTML, XML, SAX, and Reader parser.
require "themoviedb"              # Provides a simple, easy to use interface for the Movie Database API.
require "imdb"                    # Easily use Ruby or the command line to find information on IMDB.com.
require "MovieDB/data_analysis"
require "MovieDB/secret"
require "MovieDB/data_store"
require "MovieDB/data_process"
require "MovieDB/base"
# load "/Users/albertmckeever/Sites/movieDB/lib/movieDB/relation/query_methods.rb"
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
        arr ||= []

        if ids.is_a? Array
          ids.each do |n|
            arr << n.to_s
          end
          @imdb_ids = arr
        end

        if ids.is_a? String
          arr << ids
          @imdb_ids = arr
        end

        if ids.is_a? Numeric
          arr << ids.to_s
          @imdb_ids = arr
        end

        # raise ArgumentError, 'Please provide 2 or more IMDd ids.' if @imdb_ids.length <= 1

        find_movie
      end

      def imdb_id
        movie = MovieDB::Movie.new
        movie.find(:keys)
      end

      # Check redis to see if movie exists?
      # If movie hasn't been cached, then fetch
      # from IMDb and TMDb.
      # Store data to redis.
      def find_movie
        movie = MovieDB::Movie.new
        movie = movie.find_movie_by(:all_ids, @imdb_ids)

        (movie.nil? || movie.all?(&:empty?)) ? imdb_tmdb_lookup : movie
      end

      def imdb_tmdb_lookup # :nodoc:
        @imdb_ids.each do |imdb_id|
          query_imdb(imdb_id)
          query_tmdb(imdb_id)
        end
      end


      # Fetch the movie from both IMDb and TMDb repositories.
      #
      # Future release of this software will scrap IMDb data from boxofficemojoAPI.com
      # using Mechanize gem.
      #
      # Reference https://github.com/skozilla/BoxOfficeMojo/tree/master/boxofficemojoAPI
      # for the api.
      def query_imdb(imdb_id)
        # Query IMDb
        imdb = Imdb::Movie.new(imdb_id)

        raise NameError, "#{imdb_id} is an invalid IMDb id." if imdb.title.nil?

        imdb_data = imdb unless imdb.title.nil?

        save_to_redis(imdb_data, imdb_id)
      end

      def query_tmdb(imdb_id) # :nodoc:
        # Query TMDb
        Tmdb::Api.key(Movie.key)
        tmdb = Tmdb::Movie.detail("tt#{imdb_id}")

        tmdb_data = tmdb unless tmdb['title'].nil?

        save_to_redis(tmdb_data, imdb_id)
      end

      def save_to_redis(imdb_tmdb_data, imdb_id)
        MovieDB::DataStore.write_data(imdb_tmdb: imdb_tmdb_data, id: imdb_id)
      end
    end
  end
end

m = MovieDB::Movie.new
ids = [ "4178092",  "3079380", "0369610"]
m.imdb_id = ids
# # m.imdb_id
# m.imdb_id = "4178092"
m.all
# p m.keys
# p m.json
# m.select(attr: ["title", "revenue"], ids: ['0120338', '2488496'] )
m.pretty_json

