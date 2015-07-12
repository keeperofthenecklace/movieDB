require 'MovieDB'
require 'logger'

module MovieDB
  # Analyzing, inspecting, cleaning, transforming and modeling data.
  # The stored log files should not exceed 5 MB and will be keep for a day.
  class DataAnalysis < MovieDB::Movie
    module AnalysisOfVariance
      module LeastSquares
        module Statistic
          def basic_statistic(directory_name)
            open_spreadsheet(directory_name)
            @directory_name = directory_name

            if check_imdb_count == true
              Logger.new('movieDB.log', 5 * 1024 * 1024, 'daily').error "Error. A minimum of 2 Imdb id's are required."
            else
              perform_computation
              insert_data_to_existing_xls_file
            end
          end

          def open_spreadsheet(directory_name)
            @book = Spreadsheet.open File.join('reports', directory_name)
            @sheet = @book.worksheet(0)
            @sheet.column(22).width = "worldwide_gross".length
          end

          def check_imdb_count
            @sheet.rows.count - 1 == 1
          end

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
            total_columns = 22
            @column = []

            @row_count = @sheet.rows.count

            1.upto(total_columns) do |c|
              @column = []

              @sheet.each_with_index do |row, i|
                @column << @sheet[i, 0 + c]
              end

              @column.shift
              @column.compact!

              if @column.all? { |i| (1..99_999_999_999).include? (i) }
                n = @column.count
                    @column.sort!

                @mean = @column.sum / n
                @range = @column.max - @column.min

                freq = @column.inject(Hash.new(0)) { |h, v| h[v] += 1; h }
                @mode =  @column.sort_by { |v| freq[v] }.last # Find the mode

                @column_squared = []
                @column.each do |col|
                  @column_squared << col**2
                end

                @sum_of_column = @column.sum
                @sum_of_column_squared = @column_squared.sum
                @standard_dev = Math.sqrt((@sum_of_column_squared - ((@sum_of_column) * (@sum_of_column) / n)) / (n - 1))

                 if n.odd?
                   index = (n + 1) / 2
                   @median = @column[index - 1]
                 else
                   middle_index = n / 2
                   right_index = middle_index + 1
                   @median = (@column[middle_index - 1] + @column[right_index - 1]) / 2
                 end
              else
                @median = "N/A"
                @mean = "N/A"
                @range = "N/A"
                @mode = "N/A"
                @standard_dev = "N/A"
              end

              @sheet[@row_count + 2, 0 ] =  "Mean"
              @sheet[@row_count + 2, 0 + c] = @mean

              @sheet[@row_count + 3, 0] =  "Median"
              @sheet[@row_count + 3, 0 + c] =  @median

              @sheet[@row_count + 4, 0 ] =  "Range"
              @sheet[@row_count + 4, 0 + c] =  @range

              @sheet[@row_count + 5, 0] =  "Mode"
              @sheet[@row_count + 5, 0 + c] =  @mode

              @sheet[@row_count + 6, 0] =  "Standard Deviation"
              @sheet[@row_count + 6, 0 + c] =  @standard_dev
            end
          end

          def report_name
            module_nesting = Module.nesting[0].to_s.gsub('::', ' ').split()
            count = module_nesting.size
            @data_analysis_name = module_nesting[count - 1]
            @data_analysis_name << '_' <<  @directory_name.gsub('_.xls', '')
          end

          def insert_data_to_existing_xls_file
            filename = ("#{report_name}.xls")
            @book.write File.join('reports', filename)
            return filename
          end
        end

        module CoefficientOfDetermination; end
        module DiscreteLeastSquaresMeshless; end
        module ExplainedSumOfSquares; end
        module FractionOfVarianceUnexplained; end
        module GaussNewtonAlgorithm; end
        module IterativelyReweightedLeastSquares; end
        module LackOfFitSumOfSquares; end
        module LeastSquaresSupportVectorMachine; end
        module MeanSquaredError; end
        module MovingLeastSqares; end
        module NonLinearIterativePartialLeastSquares; end
        module NonLinearLeastSquares; end
        module OrdinaryLeastSquares; end
        module PartialLeastSquaresRegression; end
        module PartitionOfSumsOfSquares; end
        module ProofsInvolvingOrdinaryLeastSquares; end
        module ResidualSumOfSquares; end
        module TotalLeastSquares; end
        module TotalSumOfSquares; end
      end
    end

    module EstimationOfDensity
      module ClusterWeightedModeling; end
      module DensityEstimation; end
      module DiscretizationOfContinuousFeatures; end
      module MeanIntegratedSquaredError; end
      module MultivariateKernelDensityEstimation; end
      module VariableKernelDensityEstimation; end
    end

    # primarily EDA is for seeing what the data can
    # tell us beyond the formal modeling or hypothesis testing task.
    # The output will be a visual material.
    module ExploratoryDataAnalysis
      module DataReduction; end
      module TableDiagonalization; end
      module ConfiguralFrequencyAnalysis; end
      module MedianPolish; end
      module StemAndLeafDisplay; end
    end


    module DataMining
      module AppliedDataMining; end
      module ClusterAnalysis; end
      module DimensionReduction; end
      module AppliedDataMining; end
    end

    module RegressionAnalysis
      module ChoiceModelling; end

      module GeneralizedLinearModel
        module BinomialRegression; end
        module GeneralizedAdditiveModel; end
        module LinearProbabilityModel; end
        module PoissonRegression; end
        module ZeroInflatedModel; end
      end

      module NonparametricRegression; end
      module StatisticalOutliers; end
      module RegressionAndCurveFittingSoftware; end
      module RegressionDiagnostics; end
      module RegressionVariableSelection; end
      module RegressionWithTimeSeriesStructure; end
      module RobustRegression; end
      module ChoiceModeling; end
    end

    module Resampling
      module BootstrappingPopulation; end
    end

    module SensitivityAnalysis
      module VarianceBasedSensitivityAnalysis; end
      module ElementaryEffectsMethod; end
      module ExperimentalUncertaintyAnalysis; end
      module FourierAmplitudeSensitivityTesting; end
      module Hyperparameter; end
    end

    module TimeseriesAnalysis
      module FrequencyDeviation; end
    end
  end

  class ExportData
    def write_spreadsheet(data, data_analysis_name)
      begin data_analysis.is_a? String
        @data_analysis_name = data_analysis_name.split.join.gsub('_', ' ').downcase.to_s
        case data_analysis_name
        when "coefficient of determination"
          write_coefficient_of_determination
        when  "discrete least squares meshless method"
          write_discrete_least_squares_meshless_method
        else
          write_discrete_least_squares_meshless_method
        end
      rescue
        raise ArgumentError, 'invalid attribute'
      end
    end

    def write_coefficient_of_determination
      book = Spreadsheet::Workbook.new

      sheet1 = book.create_worksheet name: "Data Analysis: #{@data_analysis_name}"
      sheet1.row(0).concat %w{title released_date worldwide_gross}

      data.each_with_index do |value, index|
        sheet1[1, index] = "#{value}"
      end
    end

  end
end
