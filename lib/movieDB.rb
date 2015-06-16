require "rubygems"
require "open-uri"                # is an easy-to-use wrapper for net/http, net/https and net/ftp.
require "nokogiri"                # is an HTML, XML, SAX, and Reader parser.
require "themoviedb"              # Provides a simple, easy to use interface for the Movie Database API.
require "imdb"                    # Easily use Ruby or the command line to find information on IMDB.com.
require "spreadsheet"             # A library designed to read and write Spreadsheet Documents.
require "MovieDB/base"
require "MovieDB/data_analysis"
require "MovieDB/secret"
require "MovieDB/data_export"
require "redis"
require "json"

unless defined? MovieDB::Movie
  module MovieDB #:nodoc:
  # Create a new movie record. The values are stored in the key-value data store.
  #
  # Default values are supplement during the instantiation of the class.
  # Those values are overriden when you provide one.
  #
  # You can use it like this:
  #
  #   movie = Movie.new()
  #   movie.title = "When Sally Met Harry"
  #
  # You can raise a MovieError like this:
  #
  #   raise MovieError unless Movie.title_present?
    class Movie < MovieDB::Base
      include StatusChecker

      extend MovieDB::DataExport
      extend MovieDB::Secret::Lock

      const_set("MovieError",  Class.new(StandardError))

      attr_accessor :title,
                    :cast_members,
                    :cast_characters,
                    :cast_member_ids,
                    :cast_members_characters,
                    :trailer_url,
                    :director,
                    :writers,
                    :filming_locations,
                    :company,
                    :genres,
                    :languages,
                    :countries,
                    :length,
                    :plot,
                    :poster,
                    :rating,
                    :votes,
                    :mpaa_rating,
                    :tagline,
                    :year,
                    :release_date,
                    :revenue

      DEFAULT_TITLE = "Method Missing 2: Rails Roars!"
      DEFAULT_CAST_MEMBERS = ["David Black", "Paola Perotta", "Obie Fernandez", "David Chelimsky"]
      DEFAULT_CAST_CHARACTERS = ["Developer", "Police Officer", "Hunter", "Hostage"]
      DEFAULT_CAST_MEMBERS_CHARACTERS = ["David Black => Developer", "Paola Perotta => Police Officer",
                                 "Obie Fernandez =>Hunter", "David Chelimsky =>Hostage"]
      DEFAULT_CAST_MEMBER_IDS = ["nm3901234", "nm4901244", "nm5901235", "nm3601266"]
      DEFAULT_TRAILER_URL = "http://imdb.com/video/screenplay/vi581042457/"
      DEFAULT_DIRECTOR = "Yukihiro 'Matz' Matsumoto"
      DEFAULT_WRITERS = 'David Heinemeier Hansson'
      DEFAULT_FILMING_LOCATIONS = ["Manhattan, New York, USA"]
      DEFAULT_COMPANY = "Open Source Community Film Corporation"
      DEFAULT_GENRES = ["Bromantic", "Syfy"]
      DEFAULT_LANGUAGES = ["English", "German", "Italian"]
      DEFAULT_COUNTRIES = ["USA", "Germany", "Italy"]
      DEFAULT_LENGTH = 146
      DEFAULT_PLOT = ["David Black, a ruby developer, tries to write his flagship ruby book 'The Well-Grounded Rubyist vol. 186' only to find out that Ruby 9.0.2 and Rails 16.0.3 release dates have been postponed"]
      DEFAULT_POSTER = "http://ia.media-imdb.com/images/M/MV5BMTY@@.jpg"
      DEFAULT_RATING = 9.9
      DEFAULT_VOTES = 110636
      DEFAULT_MPAA_RATING = "Rated R for dynamic OOD language usage and private methods access (certificate 33087)"
      DEFAULT_TAGLINE = 'Only One MVC Will Rule Them All.'
      DEFAULT_YEAR = 2013
      DEFAULT_RELEASE_DATE = "11 October 2013 (USA)"
      DEFAULT_REVENUE = 456790

      def initialize(attributes = {})
        $IMDB_ATTRIBUTES_HEADERS = movie_attr = %w(title cast_members cast_characters cast_member_ids cast_members_characters
                        trailer_url director writers filming_locations company genres languages countries
                        length plot poster rating votes mpaa_rating tagline year release_date revenue)

        movie_attr.each do |attr|
          self.send("#{attr}=", (attributes.has_key?(attr.to_sym) ? attributes[attr.to_sym] : self.class.const_get("DEFAULT_#{attr.upcase}")))
        end
      end

      # This is empty the container
      #
      # Futire release of this software will be using the boxofficemojoAPI
      # https://github.com/skozilla/BoxOfficeMojo/tree/master/boxofficemojoAPI
      #
      # def clear_data_store
      #   return @movie_DS = []
      # end

      # You can Imdb movie data like this:
      #
      #   MovieDB::Movie.send(:get_multiple_imdb_movie_data, "2024544", "1800241")
      #
      # Example: You can also collect the title attribute:
      #
      #    MovieDB::Movie.instance_eval { filter_movie_attr("title") }
      def self.get_data(*args)
        @db_redis ||= Redis.new

        @db_redis.del "revenue"

        @imdb_id = []

        Tmdb::Api.key(Movie.key)

        args.flatten.each do |value|
          @imdb_id << value

          movie_info = Movie.new
          @movie_data = Imdb::Movie.new(value)

          movie_detail = Tmdb::Movie.detail("tt#{value}")

          $IMDB_ATTRIBUTES_HEADERS.each do |attr_key|
            begin @movie_data.send(attr_key)
              attr_value = @movie_data.send(attr_key)
            rescue => e
              attr_value = movie_detail['revenue']
            end

            @db_redis.hset "movie:#{value}", "#{attr_key}", "#{attr_value}" # Adding a hash data type.

            @db_redis.lpush "#{attr_key}", "#{attr_value}" if attr_value.is_a? Numeric # Adding a list data type.

            @db_redis.expire "#{attr_key}", 1800

            @db_redis.expire "movie:#{value}", 1800
          end
        end

        write_imdb_data_to_xls
      end

      def self.write_imdb_data_to_xls
        Movie.export_movie_data(@db_redis, @imdb_id)
      end
    end
  end
end
