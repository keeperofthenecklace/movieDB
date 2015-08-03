require "MovieDB/data_store"
require "MovieDB/support/reporting"

module MovieDB
  module Relation
    module QueryMethods

      def find(method)
        fetch_data(method)
      end
      # This will build and fetch all objects from redis
      # database, converting them into JSON.

      def find_movie_by(method, *ids)
        check_argument(method, ids)
        check_rate_limit(ids)
        fetch_data(method, ids)
      end

      def select(attr:, ids:)
        check_argument(:select, attr, ids)
        fetch_data(:select, attr, ids)
      end

      def all
        find(:all)
      end

      def keys
        find(:keys)
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

      def fetch_data(method, ids = nil)
        if ids.nil?
          return MovieDB::DataStore.get_data(method)
        else
          ids.flatten!.each do |id|
            return MovieDB::DataStore.get_data(method, id)
          end
        end
      end

      private

        def check_argument(method, *args) # :nodoc:
          if args.flatten!.empty?
            raise ArgumentError, "The method #{method}() must contain arguments."
          end
        end
    end
  end
end