require "MovieDB/data_store"
require "MovieDB/support/reporting"
require "imdb"
require "themoviedb"
# require "MovieDB/secret"
load "/Users/albertmckeever/Sites/movieDB/lib/movieDB/secret.rb"


module MovieDB
  module Relation
    module QueryMethods
      extend MovieDB::Secret::Lock

      def store_data(ids)
        check_rate_limit(ids)

        ids.each do |id|
          movie_exists?(id) ? true : imdb_tmdb_lookup(id)
        end
      end

      def get(*ids)
        store_data(ids_to_array(ids))

          arr = []

        ids.each do |id|
          arr << (mgetall(id))
        end

        $movie_data = arr
      end

      def mgetall(id)
        movie = MovieDB::DataStore.get_data(:all, id)
      end

      def mset(record, id)
        MovieDB::DataStore.write_data(imdb_tmdb: record, id: id)
      end

      def all_ids
        MovieDB::DataStore.get_data(:scan).flatten.delete_if{ |n| n == "0" }
      end

      def delete_all
        $get_data.clear
        return MovieDB::DataStore.get_data(:flushall)

      end

      def movie_exists?(id)
        !mgetall(id).empty?
      end

      def imdb_tmdb_lookup(id) # :nodoc:
        query_imdb(id)
        query_tmdb(id)
      end

      # Fetch the movie from both IMDb and TMDb repositories.
      #
      # Future release of this software will scrap IMDb data from boxofficemojoAPI.com
      # using Mechanize gem.
      #
      # Reference https://github.com/skozilla/BoxOfficeMojo/tree/master/boxofficemojoAPI
      # for the api.
      def query_imdb(id)
        # Query IMDb
        imdb = Imdb::Movie.new(id)

        raise NameError, "#{id} is an invalid IMDb id." if imdb.title.nil?

        mset(imdb, id)
      end

      def query_tmdb(id) # :nodoc:
        Tmdb::Api.key(MovieDB::Secret::Lock.key)

        tmdb = Tmdb::Movie.detail("tt#{id}")

        raise NameError, "#{id} is an invalid TMDb id." if tmdb.nil?

        mset(tmdb, id)
      end

      def fetch_data(method, ids = nil)
        if ids.nil?
          MovieDB::DataStore.get_data(method)
        else
          ids.each do |id|
            MovieDB::DataStore.get_data(method, id)
          end
        end
      end

      private

        def check_argument(method, ids) # :nodoc:
          if ids.flatten!.empty?
            raise ArgumentError, "The method #{method}() must contain arguments."
          end
        end

        # IMDb current limits are 40 requests every 10
        # seconds and are limited by IP address, not API key.
        def check_rate_limit(ids)
          if ids.length >= 40
            MovieDB::Support::Reporting.warn(<<-MSG.strip!)
            Reduce the amount of IMDb ids. \nYou have exceeded the rate limit.
            MSG
          else
            MovieDB::Support::Reporting.silenced
          end
        end
    end
  end
end