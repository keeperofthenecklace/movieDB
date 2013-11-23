  ##
  # Check the film release and updates the status.
  #
  # Example
  #
  # movie = Movie.new(film_release: ['theatrical', 'print'])
  # movie.status_check #=> 'Modified Wide Release'

module MovieDB
  module StatusChecker
    def self.included(base)
      base.class_eval {

      def theatrical_released?
          self.movie_status == 'theartrical'
      end

      def video_released?
        self.movie_status == 'video'
      end

      def television_released?
        self.movie_status == 'television'
      end

      def internet_released?
        self.movie_status == 'internet'
      end

      def print_released?
        self.movie_status == 'print'
      end

      def status_check
          case when self.theatrical_released? && self.television_released? && self.video_released? && self.print_released?
            "Wide Release"
          when self.theatrical_released? && self.print_released?
            "Modified Wide Release"
        when self.theatrical_released? && (self.internet_released? || self.print_released?)
          "Exclusive and Limited Runs"
        when  self.theatrical_released? || self.television_released? || self.video_released? || self.print_released?
          "Territorial Saturation"
        else
          "Not Released"
        end
    end
    }
  end
 end
end
