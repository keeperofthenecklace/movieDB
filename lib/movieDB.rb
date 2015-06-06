require "rubygems"
require "time"
require "open-uri"
require "nokogiri"
require "zimdb"
require "themoviedb"
require "imdb"
require "spreadsheet"
require "MovieDB/base"
require "MovieDB/data_analysis"
require "MovieDB/secret"

unless defined? MovieDB::Movie
  module MovieDB::Base #:nodoc:
  # = Movie DB
  #
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
      DEFAULT_TAGLINE = 'Only One MVC Will rule Them All.'
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
                        bafta_nomination bafta_wins film_release )

        movie_attr.each do |attr|
          self.send "#{attr}=", (attributes.has_key?(attr.to_sym) ? attributes[attr.to_sym] : self.class.const_get("DEFAULT_#{attr.upcase}"))
        end

      end

      # Iterating through the block for title duplication.
      # Return true if the array is not nil.
      # Absence of title duplications should yield an empty array.

      def self.title_present?
        titles = Movie.instance_eval{ filter_movie_attr("title") }
        @title_exist = titles.detect{ |duplicates| titles.count(duplicates) > 1 }
        !@title_exist.nil?
      end

      def unique_id
        @unique_id ||= "#{Date.today}#{Array.new(9){rand(9)}.join}".gsub('-','')
      end

      class << self
        # Get a single data from imdb database.
        #
        # TODO: This method should be deprecated in the next version release.
        def get_imdb_movie_data(value)
          puts  zimdb_value = "tt" << value.to_s

          @movie_data = Imdb::Movie.new(value.to_s)
          @zimdb_data = Zimdb::Movie.new(id: zimdb_value)

          # return @movie_data
          # return @zimdb_data
        end

        def global_movie_data_store
          return  $GLOBAL_MOVIE_DS
        end
        # You can add multiple Imdb ids like this:
        #
        #   MovieDB::Movie.send(:get_multiple_imdb_movie_data, "2024544", "1800241")
        #
        #  Example: You can collect the arrays of the title attributes
        #
        #    MovieDB::Movie.instance_eval{filter_movie_attr("title")}
        def get_multiple_imdb_movie_data(*args)
          if args.size == 1
           puts "*" * 41
           puts "* A minimum of 2 Imdb id's are required *"
           puts "* To perform statistical data analysis  *"
           puts "* You only have ONE Imdb id entered     *"
           puts "*" * 41
          end

          args.each do |value|
            get_imdb_movie_data(value)
            @movie_DS ||=[]
            movie_info = Movie.new

            # query themoviedb.org for film revenue
            # Will return a 0 revenue if record doesn't exist at
            # themoviedb.org
            tmdb_arr = []
            tmdb_key =  MovieDB::Movie.key
            Tmdb::Api.key(tmdb_key)
            tmdb = Tmdb::Movie.find(@movie_data.title)

            if tmdb.empty?
              tmdb_data = Tmdb::Movie.new
              tmdb_data.revenue = 0
            else
              tmdb.select { |t| tmdb_arr << t.id }
              tmdb_id = tmdb_arr[0]
              tmdb_data = Tmdb::Movie.detail(tmdb_id)
            end

            begin
              movie_info.title = Array.new << @movie_data.title
              movie_info.cast_members =  @movie_data.cast_members.flatten
              movie_info.cast_characters = @movie_data.cast_characters
              movie_info.cast_member_ids = @movie_data.cast_member_ids
              movie_info.cast_members_characters = @movie_data.cast_members_characters
              movie_info.trailer_url =  @movie_data.trailer_url.nil? ? 'No Trailer' : @movie_data.trailer_url
              movie_info.director =  @movie_data.director.flatten
              movie_info.writer = Array.new << @zimdb_data.writer
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
              movie_info.worldwide_gross = Array.new << tmdb_data.revenue
              movie_info.unique_id =  @unique_id

              # TODO: Write API to request data from AMPAS.
              #
              # Example: We can fetch the data like this:
              #
              #   movie_info.academy_award_nomination = academy_award_nomination
              #   movie_info.academy_award_wins = academy_award_wins
              #   movie_info.golden_globe_nominations = golden_globe_nominations
              #   movie_info.golden_globe_wins = golden_globe_wins
              #   movie_info.bafta_nomination = bafta_nomination
              #   movie_info.bafta_wins = bafta_wins
              $GLOBAL_MOVIE_DS = @movie_DS << movie_info
              rescue
                raise ArgumentError, 'invalid imbd id'
            end

          end

          return @movie_DS
        end

        def clear_data_store
          @movie_DS = []

          return @movie_DS
        end

        # Filter the data store for the movie attributes. Return an array of the attributes.
        #
        # Example
        #
        #   Movie.filter_movie_attr('cast_members') #=> ["Chris_Hemsworth", "Natalie_Portman"]
        def filter_movie_attr(attr)
          attr_raw = attr
          attr_sym = attr.to_sym

          raise ArgumentError, ("#{attr_sym} is not a valid attribute." if !attr_sym == :director && :cast_members)
          filtered = @movie_DS.select{ |ds| ds.attr_title? }.map(&attr_sym)#.flatten
          attr_raw == ('languages' && 'title') ? filtered : filtered#.uniq
        end

      end

      private_class_method :get_multiple_imdb_movie_data, :filter_movie_attr, :get_imdb_movie_data

      def attr_title
        !@title.nil?
      end
      alias :attr_title? :attr_title

    end
  end
end
