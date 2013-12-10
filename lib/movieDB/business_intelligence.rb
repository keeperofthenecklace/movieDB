
  ##
  #TODO:Work-In_Porgress 

module MovieDB
  
  class BusinessIntelligence
    attr_accessor :movie_id1, :movie_id2

    def initialize(movie_id1 = nil, movie_id2 = nil)
      @movie_id1 = Imdb::Movie.new(movie_id1)
      @movie_id2 = Imdb::Movie.new(movie_id2)
    end
    
  end
end
