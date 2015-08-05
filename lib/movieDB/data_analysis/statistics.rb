require 'daru'
require 'MovieDB'
require 'facter'

module MovieDB
  class Data_Analysis < MovieDB::Movie
    module Statistics

      # Calculate mean of movies.
      def mean
        compute_stats :mean
      end

      # Calculate sample standard deviation of movies.
      def std
        compute_stats :std
      end

      # Calculate sum of movies
      def sum
        compute_stats :sum
      end

      # Count the number of non-nil values in each vector.
      def count
        compute_stats :count
      end

      # Calculate the maximum value of each movie.
      def max
        compute_stats :max
      end

      # Calculate the minimmum value of each movie.
      def min
        compute_stats :min
      end

      # Compute the product of each movie.
      def product
        compute_stats :product
      end

      def standardize

      end

      def describe

      end

      # Calculate sample variance-covariance between the movies.
      def covariance

      end

      alias :cov :covariance

      # Calculate the correlation between the movies.
      def correlation

      end

      alias :corr :correlation

      private

        def compute_stats method
          raise ArgumentError, 'Please provide 2 or more IMDd ids.' if @imdb_ids.length <= 1
          Daru::Maths::Statistics
          df = Daru::DataFrame.new({
                                       a: ['foo'  ,  'foo',  'foo',  'foo',  'foo',  'bar',  'bar',  'bar',  'bar'],
                                       b: ['one'  ,  'one',  'one',  'two',  'two',  'one',  'one',  'two',  'two'],
                                       c: ['small','large','large','small','small','large','small','large','small'],
                                       matrix: [1,2,2,3,3,4,5,6,7],
                                       spy: [2,4,4,6,6,8,10,12,14],
                                       lotr: [10,20,20,30,30,40,50,60,70]
                                   },name: :movie, index: [:title, :revenue, :cast, :cloak, :shoes, :blue, :green, :yello, :brown])

          p df.mean
        end
    end
  end
end