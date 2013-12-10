require 'rubygems'
require 'active_support/all'
require 'time'
require 'MovieDB/base'
require "open-uri"
require 'nokogiri'
require "imdb"
require "MovieDB/Person"
require "movieDB/version"

  ##
  # Create a new movie record. The values are stored in the key-value data store.
  #
  # Default values are supplement during the instantiation of the class.
  # Those values are overriden when you provide one.
  #
  # Example
  # movie = Movie.new()
  # movie.title = "When Sally Met Harry"

unless defined? MovieDB::Movie
  module MovieDB
     class Movie < MovieDB::Base

          prepend StatusChecker

          # Use example
          # raise MovieError unless Movie.title_present?

          const_set("MovieError",  Class.new(StandardError))

          attr_accessor :title, :cast, :director, :released_date, :released_date, :film_release, :writer,
                        :unique_id, :genre, :academy_award_nomination, :academy_award_wins, :golden_globe_nominations, :golden_globe_wins,
                        :bafta_nomination, :bafta_wins, :worldwide_gross
          alias :released? :film_release

          DEFAULT_TITLE = "Method Missing"
          DEFAULT_CAST = ['David Black', "Paola Perotta", "Obie Fernandez", "David Chelimsky"]
          DEFAULT_DIRECTOR = "Yukihiro 'Matz' Matsumoto"
          DEFAULT_RELEASED_DATE = "2005-12-13"
          DEFAULT_FILM_RELEASE = ['theatrical', 'video', 'television', 'internet', 'print']
          DEFAULT_WRITER = 'David Heinemeier Hansson'
          DEFAULT_UNIQUE_ID = @unique_id
          DEFAULT_GENRE = ["Bromantic", "Syfy"]
          DEFAULT_ACADEMY_AWARD_NOMINATION = 4
          DEFAULT_ACADEMY_AWARD_WINS = 3
          DEFAULT_GOLDEN_GLOBE_NOMINATIONS = 4
          DEFAULT_GOLDEN_GLOBE_WINS = 2
          DEFAULT_BAFTA_NOMINATION = 3
          DEFAULT_BAFTA_WINS = 1
          DEFAULT_WORLDWIDE_GROSS = "$9750 Million"

          def initialize(attributes = {})
            movie_attr = %w(title cast director released_date film_release writer unique_id 
                      genre academy_award_nomination academy_award_wins golden_globe_nominations
                      golden_globe_wins bafta_nomination bafta_wins worldwide_gross)
            movie_attr.each do |attr|
              self.send "#{attr}=", (attributes.has_key?(attr.to_sym) ? attributes[attr.to_sym] : self.class.const_get("DEFAULT_#{attr.upcase}"))
            end
          end

    ##
    # Iterating through the block for title duplication.
    # Return a true if the array is not nil.
    # Absence of title duplications should yield an empty array.

          def self.title_present?
            titles = Movie.instance_eval{filter_movie_attr("title")}
            @title_exist = titles.detect{|duplicates|titles.count(duplicates) > 1}
            !@title_exist.nil?
          end

          def unique_id
            @unique_id ||= "#{Date.today}#{Array.new(9){rand(9)}.join}".gsub('-','')
          end

          class << self
            def create_movie_info(title, cast, director, released_date, film_release, writer, unique_id, 
                    genre, academy_award_nomination, academy_award_wins, golden_globe_nominations,
                    golden_globe_wins, bafta_nomination, bafta_wins, worldwide_gross)

              @movie_DS ||=[]
              movie_info = Movie.new
              movie_info.title = title
              movie_info.cast = cast 
              movie_info.director = director 
              movie_info.released_date = released_date
              movie_info.film_release = film_release 
              movie_info.writer = writer
              movie_info.unique_id = @unique_id
              movie_info.genre = genre
              movie_info.academy_award_nomination = academy_award_nomination
              movie_info.academy_award_wins = academy_award_wins
              movie_info.golden_globe_nominations = golden_globe_nominations
              movie_info.golden_globe_wins = golden_globe_wins
              movie_info.bafta_nomination = bafta_nomination 
              movie_info.bafta_wins = bafta_wins
              movie_info.worldwide_gross = worldwide_gross
              @movie_DS << movie_info

               if Movie.title_present?
                 raise ArgumentError, "The title #{@title_exist} has already been taking"
               else
                 return @movie_DS
               end

            end

    ##
    # Filter the data store for the movie attributes. Return an array of the attributes.
    #
    # Example.
    # Movie.filter_movie_attr('cast') #=> ["Chris_Hemsworth", "Natalie_Portman"]

            def filter_movie_attr(attr)
              attr_raw = attr
              attr_sym = attr.to_sym

              raise ArgumentError, "#{attr_sym} is not a valid attribute." if !attr_sym == :director && :cast
              filtered = @movie_DS.select{|ds| ds.attr_title?}.map(&attr_sym).flatten
              attr_raw == 'title' ? filtered : filtered.uniq
            end
          end
          private_class_method :create_movie_info, :filter_movie_attr

          def attr_title
            !@title.nil?
          end
          alias :attr_title? :attr_title

    ##
    # Use the double splat to capture auxillary arguments.
    #
    # Example
    #
    # capture(synopsis: "Last Vegas - Four geriatric friends vow to set Las Vegas Ablaze.")

          def capture(**opts)
            @synopsis = opts
          end

          def wrap(synopsis, before: "(", after: ")")
            "#{before}#{synopsis}#{after}"
          end
        end
    end
end

