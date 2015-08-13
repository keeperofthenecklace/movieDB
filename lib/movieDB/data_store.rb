require 'redis'
require 'json'
require 'imdb'

# Movie data fetched from IMDb is stored as a hash data type in redis.
# The key and values are written into a spreadsheet for later data analysis.
module MovieDB
  module DataStore
    IMDB_METHODS = [:title, :also_known_as, :cast_members, :cast_characters, :cast_members_characters,
                    :director, :writers, :trailer_url, :genres, :languages, :countries, :length, :company, :plot, :plot_synopsis,
                    :plot_summary, :poster, :rating, :votes, :tagline, :mpaa_rating, :year, :release_date, :filming_locations]

    # Create a redis instance.
    def self.initialize_redis
      @redis_db ||= Redis.new(connect_timeout: 20, timeout: 20)
    end

    # Store to Redis for 30 minutes.
    # Traverse hash for values and write to redis.
    # Checking if revenue attribute exists.
    # since, IMDb do not provide the Gross Profit,
    # We get that info from TMDb.
    def self.write_data(**options)
      if options[:imdb_tmdb].is_a? Hash
       mid =  options[:imdb_tmdb]["imdb_id"].delete('tt')

        options.each_pair do |k, v|
          if v.is_a? Hash
            v.each_pair do |j, w|
              @redis_db.hsetnx "#{mid}", "#{j}", "#{w}"
            end
          end
        end
      else
        MovieDB::DataStore::IMDB_METHODS.each do |method|
          @redis_db.hsetnx "#{options[:imdb_tmdb].id}", method.to_s, "#{options[:imdb_tmdb].send(method)}"
        end
      end

      @redis_db.expire "#{options[:id]}", "#{options[:expire]}"
    end

    # You can fetch one data at at a time.
    # Do not send an array of arguments.
    #
    # Example the following is accepted.
    #
    #   MovieDB::Movie.get_data('0369610')
    #
    # Not accepted:
    #    MovieDB::Movie.get_data(['0369610', 3079380])
    def self.get_data(method, id = nil)
      initialize_redis

      case method
        when :all
          return @redis_db.hgetall "#{id}"
        when :hkeys
          return @redis_db.hkeys "#{id}"
        when :hvals
          return @redis_db.hvals "#{id}"
        when :scan
          return @redis_db.scan 0
        when :flushall
          return @redis_db.flushall
        when :get
          return @redis_db.hgetall("#{id}")
        when :ttl
          return @redis_db.ttl("#{id}")
      else
        raise ArgumentError, "The method #{method} is invalid."
      end
    end
  end
end

