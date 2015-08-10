require 'daru'
require 'MovieDB'
require 'facter'

module MovieDB
  module DataAnalysis
    module Statistics
      # Attributes that have integers values.
      def numeric_vals
        %w(votes budget rating revenue length year mpaa_rating popularity vote_count vote_average runtime)
      end

      module_function :numeric_vals

      # Calculate mean of movies.
      def mean(**options)
        dataframes_stats(:mean, options)
      end

      # Calculate sample standard deviation of movies.
      def std(**options)
        dataframes_stats(:std, options)
      end

      # Calculate sum of movies
      def sum(**options)
        dataframes_stats(:sum, options)
      end

      # Count the number of non-nil values in each vector.
      def count(**options)
        dataframes_stats(:count, options)
      end

      # Calculate the maximum value of each movie.
      def max(**options)
        dataframes_stats(:max, options)
      end

      # Calculate the minimmum value of each movie.
      def min(**options)
        dataframes_stats(:min, options)
      end

      # Compute the product of each movie.
      def product(**options)
        dataframes_stats(:product, options)
      end

      def standardize(**options)
        dataframes_stats(:standardize, options)
      end

      def describe(**options)
        dataframes_stats(:describe, options)
      end

      # Calculate sample variance-covariance between the movies.
      def covariance(**options)
        dataframes_stats(:covariance, options)
      end

      alias :cov :covariance

      # Calculate the correlation between the movies.
      def correlation(**options)
        dataframes_stats(:correlation, options)
      end

      alias :corr :correlation

      # Prints out columns and rows  between the movies.
      def worksheet(**options)
        dataframes_stats(:worksheet, options)
      end

      private

        def dataframes_stats(method, filters = {})
          raise ArgumentError, 'Please provide 2 or more IMDd ids.' if $movie_data.length <= 1

          @data_key = {}
          @index = []

          if filters.empty?
            $movie_data.each_with_index do |movie, _|
              value_count = []

              movie.each_pair do |k, v|
                @data_key[(movie['title'].sub(" ", "_").downcase)] = value_count << (MovieDB::DataAnalysis::Statistics.numeric_vals.any? { |word| word == k } ? v.to_i : v.chars.count)
                @index << k.to_sym
              end
            end
          else
            case filters.keys[0]
            when :only
              $movie_data.each_with_index do |movie, _|
                value_count ||= []

                filters.values.flatten.each do |filter|

                  mr = movie.reject { |k, _| k != filter.to_s }

                  mr.each_pair do |k, v|
                    @data_key[(movie['title'].sub(" ", "_").downcase)] = value_count << (MovieDB::DataAnalysis::Statistics.numeric_vals.any? { |word| word == k } ? v.to_i : v.chars.count)
                    @index << k.to_sym
                  end
                end
              end
            when :except
              $movie_data.each_with_index do |movie, _|

                filters.values.flatten.each do |filter|
                  mr = movie.reject { |k, _| k == filter.to_s }
                  value_count = []

                  mr.each_pair do |k, v|
                    @data_key[(movie['title'].sub(" ", "_").downcase)] = value_count << (MovieDB::DataAnalysis::Statistics.numeric_vals.any? { |word| word == k } ? v.to_i : v.chars.count)
                    @index << k.to_sym
                  end
                end
              end
            else
              raise ArgumentError, "#{filters.keys[0]} is not a valid filter."
            end
          end

          index = @index.uniq

          compute_stats(method, @data_key, index )
        end

        def compute_stats(method, movie, index)
          df = Daru::DataFrame.new(eval(movie.to_s.gsub!('=>', ': ')),
                                   name: :movie, index: index)

          method == :worksheet ? df : df.send(method)
        end

    end
  end
end