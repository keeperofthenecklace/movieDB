
  ## Reference imdb gem 
  #TODO:Work-In_Porgress 

module MovieDB
  
  class DataMining
    attr_accessor :movie_id1, :movie_id2

    def initialize(movie_id1 = nil, movie_id2 = nil)
      @movie_id1 = Imdb::Movie.new(movie_id1)
      @movie_id2 = Imdb::Movie.new(movie_id2)
    end

    def series(value)
      if value is_a? Integer
          begin
            @serie = Imdb::Serie.new(value.to_s)
                      
          rescue
          end
      else
          raise ArgumentError, "value is not an integer"
      end
    end

    def analyse_title
      @episode.title
    end

    def analyse_season_number(season_num, episode_integer)
      @season = @serie.seasons.first
      @episode = @season.episode(integer)
    end

    def analyse_episode_number
       @episode.episode
    end

    def analyse_plot
      @episode.plot
    end

    def analyse_air_date
      @episode.air_date
    end
  end
end
