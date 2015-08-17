require 'daru'

module MovieDB
  module DataAnalysis
    module Statistics
      def numeric_vals
        %w(votes budget rating revenue length year mpaa_rating popularity vote_count vote_average runtime)
      end

      module_function :numeric_vals

      stats = [:mean, :std, :sum, :count, :max, :min, :min, :product, :standardize, :describe, :covariance, :correlation, :worksheet]

      stats.each do |method_name|
        define_method method_name do |**args|
          dataframes_stats(method_name, args)
        end
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
                @data_key[(movie['title'].sub(" ", "_").downcase)] = value_count << (MovieDB::DataAnalysis::Statistics.numeric_vals.any? { |word| word == k } ? v.to_i : v.split(' ').count)
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
                    @data_key[(movie['title'].sub(" ", "_").downcase)] = value_count << (MovieDB::DataAnalysis::Statistics.numeric_vals.any? { |word| word == k } ? v.to_i : v.join(' ').split(' ').count)
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
                    @data_key[(movie['title'].sub(" ", "_").downcase)] = value_count << (MovieDB::DataAnalysis::Statistics.numeric_vals.any? { |word| word == k } ? v.to_i : v.join(' ').split(' ').count)
                    @index << k.to_sym
                  end
                end
              end
            else
              raise ArgumentError, "#{filters.keys[0]} is not a valid filter."
            end
          end

          index = @index.uniq

          movie_numeric_vector = Hash[@data_key.map { |k, v| [k.to_s.gsub('-', '_').to_sym, v] }]
          compute_stats(method, movie_numeric_vector, index )
        end

        def compute_stats(method, movie, index)
          df = Daru::DataFrame.new(movie,
                                       name: :movie, index: index)
          method == :worksheet ? df : df.send(method)
        end
    end
  end
end

