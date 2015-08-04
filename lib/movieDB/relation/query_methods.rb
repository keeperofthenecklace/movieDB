require "MovieDB/data_store"
require "MovieDB/support/reporting"
require "imdb"
require "themoviedb"
require "MovieDB/secret"

module MovieDB
  module Relation
    module QueryMethods

      def store_data(ids)
        check_rate_limit(ids)

        ids.each do |id|
          imdb_tmdb_lookup(id) unless movie_exists?(id)
          mset(@tmdb_record, id) unless movie_exists?(id)
          mset(@imdb_record, id) unless movie_exists?(id)
        end
      end

      def movie_exists?(id)
        !mgetall(id).empty?
      end

      def mgetall(id)
        return MovieDB::DataStore.get_data(:all, id)
      end

      def mset(record, id)
        return MovieDB::DataStore.write_data(imdb_tmdb: record, id: id)
      end

      def all_ids
        p MovieDB::DataStore.get_data(:scan).flatten.delete_if{ |n| n == "0" }
      end

      def delete_all
        return MovieDB::DataStore.get_data(:flushall)
      end

      def imdb_tmdb_lookup(id) # :nodoc:
        query_tmdb(id)
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

        @imdb_record = imdb
      end

      def query_tmdb(imdb_id) # :nodoc:
        Tmdb::Api.key(Movie.key)
        @tmdb_record = Tmdb::Movie.detail("tt#{imdb_id}")
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