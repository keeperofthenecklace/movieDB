require "MovieDB/data_store"
require "MovieDB/support/reporting"

module MovieDB
  module Relation
    module QueryMethods

      # This will build and fetch all objects from redis
      # database, converting them into JSON.
      def all(*ids)
        check_argument(:all, ids)
        check_rate_limit(ids)
        fetch_data(:all, ids)
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

      def select(attr:, ids:)
        check_argument(:select, attr, ids)
        fetch_data(:select, attr, ids)
      end

      def fetch_data(method, ids)
        ary = []
        ids.flatten!.each do |id|
         ary <<  MovieDB::DataStore.get_data(method, id)
        end
        ary
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