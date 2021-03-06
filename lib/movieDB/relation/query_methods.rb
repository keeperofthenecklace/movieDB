require "MovieDB/secret"
require "MovieDB/data_store"
require "MovieDB/support/reporting"
require "themoviedb"
require "imdb"

module MovieDB
  module Relation
    module QueryMethods
      extend MovieDB::Secret

      # Fetch data from IMDb.
      # Default expiration time for stored object in redis is 1800 seconds.
      # You can set this value to what ever you like.
      #
      # Example:
      #
      #   m = MovieDB::Movie.new
      #
      #   m.fetch("0369324", "0369662", expire: 84600)
      #
      def fetch(*ids, expire: 1800)
        store_data(ids_to_array(ids), expire)

        # Collect all fetched data and assign to global variable
        arr = []

        ids.each do |id|
          arr << (hgetall(id))
        end

        $movie_data = arr
      end

      def store_data(ids, expire)
        check_rate_limit(ids)

        ids.each do |id|
          movie_exists?(id) ? true : imdb_tmdb_lookup(id, expire)
        end
      end

      # Modifying and manipulating redis objects.
      #  Example:
      #
      #   m = MovieDB::Movie.new
      #
      #   m.fetch("0369610", "3079380", "0478970")
      #
      #   m.hgetall("0369610")
      [:all, :hkeys, :hvals, :flushall, :ttl, :del].each do |method_name|
        define_method method_name do |arg|
          MovieDB::DataStore.get_data(method_name, arg)
        end
      end

      alias hgetall all

      # No argument is required.
      [:scan, :flushall].each do |method_name|
        define_method method_name do
         mn = MovieDB::DataStore.get_data(method_name)
          mn.flatten.delete_if { |n| n == "0" } if method_name == :scan
        end
      end

      alias all_ids scan
      alias delete_all flushall

      def mset(record, id, expire)
        MovieDB::DataStore.write_data(imdb_tmdb: record, id: id, expire: expire)
      end

      def movie_exists?(id)
        !hgetall(id).empty?
      end

      # Fetch the movie from both IMDb and TMDb repositories.
      #
      # Future release of this software will scrap IMDb data from boxofficemojoAPI.com
      # using Mechanize gem.
      #
      # Reference https://github.com/skozilla/BoxOfficeMojo/tree/master/boxofficemojoAPI
      # for the api.
      def imdb_tmdb_lookup(id, expire) # :nodoc:
        query_imdb(id, expire)
        query_tmdb(id, expire)
      end

      def query_imdb(id, expire) # :nodoc:
        # Query IMDb
        imdb = Imdb::Movie.new(id)

        raise NameError, "#{id} is an invalid IMDb id." if imdb.title.nil?

        mset(imdb, id, expire)
      end

      def query_tmdb(id, expire) # :nodoc:
        Tmdb::Api.key(MovieDB::Secret.key)

        tmdb = Tmdb::Movie.detail("tt#{id}")

        raise NameError, "#{id} is an invalid TMDb id." if tmdb.nil?

        mset(tmdb, id, expire)
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