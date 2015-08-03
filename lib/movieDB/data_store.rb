require 'redis'
require 'json'
require "MovieDB/support/print"

# Movie data fetched from IMDb is stored as a hash data type in redis.
# The key and values are written into a spreadsheet for later data analysis.
module MovieDB
  module DataStore
    include MovieDB::Support

    # Create a redis instance.
    def self.initialize_redis
      @redis_db ||= Redis.new
    end

    # Store to Redis for 30 minutes.
    # Traverse hash for values and write to redis.
    # Checking if revenue attribute exists.
    # since, IMDb do not provide the Gross Profit,
    # We get that info from TMDb.
    def self.write_data(**options)
      if options[:imdb_tmdb].is_a? Hash
        options.each_pair do |k, v|
          @redis_db.hsetnx "movie:#{options[:id]}", k, v
        end
      else
        puts "I am not a hash"
        options[:imdb_tmdb].title
      end

      @redis_db.expire "movie:#{options[:id]}", 1800
    end

    # You can fetch one data at at a time.
    # Do not send an array of arguments.
    #
    # Example the following is accepted.
    #     get_data('0369610')
    #
    # Not accepted:
    # get_data(['0369610', 3079380])
    # An ArgumentError will be raised.
    def self.get_data(method, id)
      initialize_redis
      return unless check_if_movie_is_present(id)

      case method
      when :all
        $data = @redis_db.hgetall("movie:#{id}")
      when :select
        $data = eval(@db_redis.hget "movie:#{imdb_id}", "#{attr_key}")
      else
        raise ArgumentError, "The method #{method} is invalid."
      end

       send_to_print unless $data.nil?
    end

    def self.send_to_print
      MovieDB::Support::Print.print_document($data, print: 'hash')
    end

      private

        def self.check_if_movie_is_present(id)
          @redis_db.hgetall(movie:"#{id}").empty?
        end
  end
end

