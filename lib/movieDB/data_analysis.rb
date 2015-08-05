require 'MovieDB'
require 'facter'
require 'logger'

module MovieDB
  # Analyzing, inspecting, cleaning, transforming and modeling data.
  # The stored log files should not exceed 5 MB.
  # The stored log files should be stored for 1 day.
  class DataAnalysis < MovieDB::Movie
    module AnalysisOfVariance
      module LeastSquares
        module Statistic_rename_this

          # Consider refactoring this Complex method.
          #
          # Calculate median as an example but COD formula must be used.
          # Mean is commonly called as average. Mean or Average is defined as the sum of
          # all the given elements divided by the total number of elements.
          #
          # Range is the difference between the highest and the lowest values in a
          # frequency distribution.
          #
          # Mode is the most frequently occurring value in a frequency distribution.
          #
          # Calculate Standard Deviation.
          # Standard deviation is a statistical measure of spread or variability.
          #
          # The standard deviation is the root mean square (RMS) deviation of the
          # values from their arithmetic mean.
          def perform_computation
            raise ArgumentError, 'Please provide 2 or more IMDd ids.' if @imdb_ids.length <= 1

          end

        end
      end
    end
  end
end
