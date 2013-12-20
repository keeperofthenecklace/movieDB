require 'MovieDB'

module MovieDB

  ##
  # Analysing, inspecting, cleaning, transforming and modeling data.

  class DataAnalysis < MovieDB::Movie
    module AnalysisOfVariance
      module LeastSquares
        module Coefficient_Of_Determination
          def coefficient_of_determination (directory_name)
            open_spreadsheet(directory_name)
            perform_computation
            insert_data_to_existing_xls_file
          end

          def open_spreadsheet(directory_name)
            @book = Spreadsheet.open File.join('reports', directory_name)
            @sheet = @book.worksheet(0)
          end

          def perform_computation

            total_columns = 17
            @column = []
            @row_count = @sheet.rows.count

            1.upto(total_columns) do |c|
              @column = [] # set instance variable to an empty array

              ##
              # loop through to collect all elements
              # The returned array includes both strings and integers elements

              @sheet.each_with_index do |row, i|
                @column << @sheet[i, 0 + c ]
              end

              @column.shift # delete the string header from the array
              @column.compact! # delete nil from the array
              row_count = @sheet.rows.count

              ##
              # Perform computation on the data collected
              # TODO: Need to use coefficienct statistical formula
              # Calculate median as an example but COD formula must be used


              if @column.all? {|i| (1..99999999).include? (i)}
                @data_processing = @column.inject do |sum, n|
                  (sum + n)/(row_count-1) 
                end
              else
                @data_processing = "N/A" # This applies to arrays that include strings elements like ["Steve McQueen", 24,"Albert McKeever"]
              end

              ##
              # Insert the processed data analysis into spreadsheet
              @sheet[@row_count + 1, 0 ] =  "Median"
              @sheet[@row_count + 1, 0 + c ] =  @data_processing
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
            #@book.worksheet(0).insert_row(4, [@data_processing ])
            #@sheet[row_count + 2, 2] = @data_processing
            #@sheet.row(row_count + 2).push "R Squared n ", @data_processing 

            @book.write File.join('reports', filename)
            return filename
          end
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

    ##
    # primarily EDA is for seeing what the data can 
    # tell us beyond the formal modeling or hypothesis testing task
    # The output will be a visual material

    module ExploratoryDataAnalysis
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

  ##
  #TODO: All Mathetical Calculations go here.

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

      # Loop through the data to collect  all values. 
      # Then values into array

      data.each_with_index do |value, index|
        sheet1[1, index] = "#{value}"
      end
    end

    def write_discrete_least_squares_meshless_method; end
    def write_discrete_least_squares_meshless_method; end
  end
end
