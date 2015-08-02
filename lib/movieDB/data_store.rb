require 'redis'
require 'json'

# Movie data fetched from IMDb is stored as a hash data type in redis.
# The key and values are written into a spreadsheet for later data analysis.
module MovieDB
  module DataStore

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
        @data = @redis_db.hgetall("movie:#{id}")
      when :select
        @data = eval(@db_redis.hget "movie:#{imdb_id}", "#{attr_key}")
      else
        raise ArgumentError, "The method #{method} is invalid."
      end

       print_document(print: 'hash')
    end

    def self.print_document(**options)
      @data.each do |d|
         d.each do |e|
           next if e.length <= 20

           return JSON.pretty_generate(eval(e)) if options[:print] == 'pretty_json'
           return JSON.generate(eval(e)) if options[:print] == 'json'
           return eval(e) if options[:print] == 'hash'
         end
      end
    end


      private

        def self.check_if_movie_is_present(id)
          @redis_db.hgetall(movie:"#{id}").empty?
        end
  end
end

