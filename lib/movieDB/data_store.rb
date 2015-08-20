require 'redis'

# Movie data fetched from IMDb is stored as a hash data type in redis.
module MovieDB
  module DataStore
    # Create a redis instance
    # with timeouts.
    def self.initialize_redis
      @redis_db ||= Redis.new(connect_timeout: 20, timeout: 20)
    end

    def imdb_methods
      [:title, :also_known_as, :cast_members, :cast_characters, :cast_members_characters,
       :director, :writers, :trailer_url, :genres, :languages, :countries, :length, :company, :plot, :plot_synopsis,
       :plot_summary, :poster, :rating, :votes, :tagline, :mpaa_rating, :year, :release_date, :filming_locations]
    end

    module_function :imdb_methods

    # The options returns with 3 keys
    # options[:imdb_tmdb], contains the movie data
    # options[:id], contains the IMDb id.
    # options[:expire] contains the expiration time for redis.
    #
    # IMDb return a status code of 34 if the resource can not be found.

    def self.write_data(**options)
      if options[:imdb_tmdb].is_a? Hash

        options.each_pair do |k, v|
            if v.is_a? Hash
              if v["status_code"] == "34"
                puts "#{options[:id]} is an invalid IMDb id."
              else
                v.each_pair do |j, w|
                    @redis_db.hsetnx "#{options[:id]}", "#{j}", "#{w}"
                end
              end
            end
        end
      else
        imdb_methods.each do |method|
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
        when :del
          return @redis_db.del("#{id}")
      else
        raise ArgumentError, "The method #{method} is invalid."
      end
    end
  end
end

