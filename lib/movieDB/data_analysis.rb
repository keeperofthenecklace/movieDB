require 'MovieDB'

module MovieDB
  # Analyzing, inspecting, cleaning, transforming and modeling data.
  #
  class DataAnalysis < MovieDB::Movie
    module AnalysisOfVariance
      module LeastSquares
        module Statistic
          def basic_statistic (directory_name)
            open_spreadsheet(directory_name)

            if check_imdb_count == true
               puts "*"*41
               puts "* A minimum of 2 Imdb id's are required *"
               puts "* To perform statistical data analysis  *"
               puts "* You only have ONE Imdb id entered     *"
               puts "*"*41
            else
              perform_computation
              insert_data_to_existing_xls_file
            end
          end

          def open_spreadsheet(directory_name)
            @book = Spreadsheet.open File.join('reports', directory_name)
            @sheet = @book.worksheet(0)

            title_format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 13

            @sheet.column(22).width = "worldwide_gross".length
          end

          def check_imdb_count
            @sheet.rows.count - 1 == 1
          end

          def perform_computation
          # Perform computation on the data collected.
          # TODO: Need to use coefficienct statistical formula.
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
            total_columns = 22
            @column = []

            @row_count = @sheet.rows.count

            1.upto(total_columns) do |c|
              @column = []

              @sheet.each_with_index do |row, i|
                @column << @sheet[i, 0 + c ]
              end

              @column.shift
              @column.compact!

              row_count = @sheet.rows.count

              if @column.all? { |i| (1..99999999999).include? (i) }
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
              @sheet[@row_count + 2, 0 + c ] = @mean

              @sheet[@row_count + 3, 0 ] =  "Median"
              @sheet[@row_count + 3, 0 + c ] =  @median

              @sheet[@row_count + 4, 0 ] =  "Range"
              @sheet[@row_count + 4, 0 + c ] =  @range

              @sheet[@row_count + 5, 0 ] =  "Mode"
              @sheet[@row_count + 5, 0 + c ] =  @mode

              @sheet[@row_count + 6, 0 ] =  "Standard Deviation"
              @sheet[@row_count + 6, 0 + c ] =  @standard_dev
            end
          end

          def report_name
            module_nesting = Module.nesting[0].to_s.gsub('::', ' ').split()
            count = module_nesting.size
            @data_analysis_name = module_nesting[count - 1]
            @data_analysis_name << '_' <<  "#{Time.now.to_s.gsub(':', '').gsub('-', '').gsub(' ', '').split('')[0..9].join}"
          end

          def insert_data_to_existing_xls_file
            filename = ("#{report_name}.xls")
            @book.write File.join('reports', filename)
            return filename
          end
        end

        module Coefficient_Of_Determination
         # TODO: Add code.
        end

        module Discrete_Least_Squares_Meshless_Method; end
        module Explained_Sum_Of_Squares; end
        module Fraction_Of_Variance_Unexplained; end
        module Gauss_Newton_Algorithm; end
        module Iteratively_Reweighted_Least_Squares; end
        module Lack_Of_Fit_Sum_Of_Squares; end
        module Least_Squares_Support_Vector_Machine; end
        module Mean_Squared_Error; end
        module Moving_Least_Sqares; end
        module Non_Linear_Iterative_Partial_Least_Squares; end
        module Non_Linear_Least_Squares; end
        module Ordinary_Least_Squares; end
        module Partial_Least_Squares_Regression; end
        module Partition_Of_Sums_Of_Squares; end
        module Proofs_Involving_Ordinary_Least_Squares; end
        module Residual_Sum_Of_Squares; end
        module Total_Least_Squares; end
        module Total_Sum_Of_Squares; end
      end
    end

    module EstimationOfDensity
      module Cluster_Weighted_Modeling; end
      module Density_Estimation; end
      module Discretization_Of_Continuous_Features; end
      module Mean_Integrated_Squared_Error; end
      module Multivariate_Kernel_Density_Estimation; end
      module Variable_Kernel_Density_Estimation; end
    end

    module ExploratoryDataAnalysis
    # primarily EDA is for seeing what the data can
    # tell us beyond the formal modeling or hypothesis testing task.
    # The output will be a visual material.
      module Data_Reduction; end
      module Table_Diagonalization; end
      module Configural_Frequency_Analysis; end
      module Median_Polish; end
      module Stem_And_Leaf_Display; end
    end


    module Data_Mining
      module Applied_DataMining; end
      module Cluster_Analysis; end
      module Dimension_Reduction; end
      module Applied_DataMining; end
    end

    module RegressionAnalysis
      module Choice_Modelling; end

      module Generalized_Linear_Model
        module Binomial_Regression; end
        module Generalized_Additive_Model; end
        module Linear_Probability_Model; end
        module Poisson_Regression; end
        module Zero_Inflated_Model; end
      end

      module Nonparametric_Regression; end
      module Statistical_Outliers; end
      module Regression_And_Curve_Fitting_Software; end
      module Regression_Diagnostics; end
      module Regression_Variable_Selection; end
      module Regression_With_Time_Series_Structure; end
      module Robust_Regression; end
      module Choice_Modeling; end
    end

    module Resampling
      module Bootstrapping_Population; end
    end

    module Sensitivity_Analysis
      module Variance_Based_Sensitivity_Analysis; end
      module Elementary_Effects_Method; end
      module Experimental_Uncertainty_Analysis; end
      module Fourier_Amplitude_Sensitivity_Testing; end
      module Hyperparameter; end
    end

    module Time_series_Analysis
      module Frequency_Deviation; end
    end
  end

  class ExportData
    def write_spreadsheet (data, data_analysis_name)
      begin data_analysis.is_a? String
        @data_analysis_name = data_analysis_name.split.join.gsub('_', ' ').downcase.to_s
        case data_analysis_name
        when "coefficient of determination"
          write_coefficient_of_determination
        when  "discrete least squares meshless method"
          write_discrete_least_squares_meshless_method
        when "discrete least squares meshless method"
          write_discrete_least_squares_meshless_method
        else
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

    def write_discrete_least_squares_meshless_method; end
    def write_discrete_least_squares_meshless_method; end
  end
end
