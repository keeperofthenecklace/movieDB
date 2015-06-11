require "rubygems"
require "time"                    # Time is an abstraction of dates and times.
require "open-uri"                # is an easy-to-use wrapper for net/http, net/https and net/ftp.
require "nokogiri"                # is an HTML, XML, SAX, and Reader parser.
require "themoviedb"              # Provides a simple, easy to use interface for the Movie Database API.
require "imdb"                    # Easily use Ruby or the command line to find information on IMDB.com.
require "spreadsheet"             # A library designed to read and write Spreadsheet Documents.
require "MovieDB/base"
require "MovieDB/data_analysis"
require "MovieDB/secret"
require "MovieDB/data_export"

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
                    :writer,
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
                    :worldwide_gross,
                    :released,
                    :unique_id,
                    :academy_award_nomination,
                    :academy_award_wins,
                    :golden_globe_nominations,
                    :golden_globe_wins,
                    :bafta_nomination,
                    :bafta_wins,
                    :film_release

      DEFAULT_TITLE = "Method Missing 2: Rails Roars!"
      DEFAULT_CAST_MEMBERS = ["David Black", "Paola Perotta", "Obie Fernandez", "David Chelimsky"]
      DEFAULT_CAST_CHARACTERS = ["Developer", "Police Officer", "Hunter", "Hostage"]
      DEFAULT_CAST_MEMBERS_CHARACTERS = ["David Black => Developer", "Paola Perotta => Police Officer",
                                 "Obie Fernandez =>Hunter", "David Chelimsky =>Hostage"]
      DEFAULT_CAST_MEMBER_IDS = ["nm3901234", "nm4901244", "nm5901235", "nm3601266"]
      DEFAULT_TRAILER_URL = "http://imdb.com/video/screenplay/vi581042457/"
      DEFAULT_DIRECTOR = "Yukihiro 'Matz' Matsumoto"
      DEFAULT_WRITER = 'David Heinemeier Hansson'
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
      DEFAULT_WORLDWIDE_GROSS = "$124.6M" # Not provided by imdb api.
      DEFAULT_UNIQUE_ID = @unique_id
      DEFAULT_ACADEMY_AWARD_NOMINATION = 4
      DEFAULT_ACADEMY_AWARD_WINS = 3
      DEFAULT_GOLDEN_GLOBE_NOMINATIONS = 4
      DEFAULT_GOLDEN_GLOBE_WINS = 2
      DEFAULT_BAFTA_NOMINATION = 3
      DEFAULT_BAFTA_WINS = 1
      DEFAULT_FILM_RELEASE = ['theatrical', 'video', 'television', 'internet', 'print']

      def initialize(attributes = {})
        $IMDB_ATTRIBUTES_HEADERS = movie_attr = %w(title cast_members cast_characters cast_member_ids cast_members_characters
                        trailer_url director writer filming_locations company genres languages countries
                        length plot poster rating votes mpaa_rating tagline year release_date worldwide_gross unique_id
                        academy_award_nomination academy_award_wins golden_globe_nominations golden_globe_wins
                        bafta_nomination bafta_wins film_release)

        movie_attr.each do |attr|
          self.send("#{attr}=", (attributes.has_key?(attr.to_sym) ? attributes[attr.to_sym] : self.class.const_get("DEFAULT_#{attr.upcase}")))
        end
      end

      # This is empty the container       #
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
        @movie_DS = []

        args.each do |value|
          movie_info = Movie.new
          @movie_data = Imdb::Movie.new(value)

          begin
            movie_info.title = Array.new << @movie_data.title
            movie_info.cast_members =  @movie_data.cast_members.flatten
            movie_info.cast_characters = @movie_data.cast_characters
            movie_info.cast_member_ids = @movie_data.cast_member_ids
            movie_info.cast_members_characters = @movie_data.cast_members_characters
            movie_info.trailer_url =  @movie_data.trailer_url.nil? ? 'No Trailer' : @movie_data.trailer_url
            movie_info.director =  @movie_data.director.flatten
            movie_info.writer =  @movie_data.writers.flatten
            movie_info.filming_locations = @movie_data.filming_locations.flatten.join(', ')
            movie_info.company = Array.new << @movie_data.company
            movie_info.genres = @movie_data.genres.flatten.join(' ').sub(' ' , ', ')
            movie_info.languages = Array.new << @movie_data.languages.flatten.join(' ').sub(' ' , ', ')
            movie_info.countries = Array.new << @movie_data.countries.flatten.join(' ').sub(' ' , ', ')
            movie_info.length = Array.new << @movie_data.length
            movie_info.plot = Array.new << @movie_data.plot
            movie_info.poster = Array.new << @movie_data.poster
            movie_info.rating = Array.new << @movie_data.rating
            movie_info.votes = Array.new << @movie_data.votes
            movie_info.mpaa_rating = Array.new << @movie_data.mpaa_rating == [nil] ? ["Not Rated"] : [@movie_data.mpaa_rating]
            movie_info.tagline = Array.new << @movie_data.tagline
            movie_info.year = Array.new << @movie_data.year
            movie_info.release_date = Array.new << @movie_data.release_date
          rescue
            raise ArgumentError, 'Invalid IMDb id entered.'
          end

          @movie_DS << movie_info
        end

        write_imdb_data_to_xls
      end

      def self.write_imdb_data_to_xls
        Movie.export_movie_data(@movie_DS)
      end
    end
  end
end
