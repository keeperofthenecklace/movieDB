require "spreadsheet"
require "MovieDB/data_analysis"
require "MovieDB"
  
  # This module will write xls document to file
  #
  # Usage @book = Spreadsheet::Workbook.new

module MovieDB
  class DataExport < MovieDB::Movie
    PATH_AOV = MovieDB::DataAnalysis::AnalysisOfVariance::LeastSquares
    include PATH_AOV::Coefficient_Of_Determination
    include PATH_AOV::Explained_Sum_Of_Squares
    include PATH_AOV::Fraction_Of_Variance_Unexplained
    include PATH_AOV::Gauss_Newton_Algorithm
    include PATH_AOV::Iteratively_Reweighted_Least_Squares
    include PATH_AOV::Lack_Of_Fit_Sum_Of_Squares
    include PATH_AOV::Least_Squares_Support_Vector_Machine
    include PATH_AOV::Mean_Squared_Error
    include PATH_AOV::Moving_Least_Squares
    include PATH_AOV::Non_Linear_Iterative_Partial_Least_Squares
    include PATH_AOV::Non_Linear_Least_Squares
    include PATH_AOV::Ordinary_Least_Squares
    include PATH_AOV::Partial_Least_Squares_Regression
    include PATH_AOV::Partition_Of_Sums_Of_Squares
    include PATH_AOV::Residual_Sum_Of_Squares
    include PATH_AOV::Total_Least_Squares
    include PATH_AOV::Total_Sum_Of_Squares

    class  << self 
      #TODO: Check the data analysis type and input inot generate method as an attribute

      def export_movie_data
       create_spreadsheet_file
       create_spreadsheet_report
       write_xls_file
      end

      def create_spreadsheet_file
        directory_name = ('reports')
        create_directory(directory_name)
        Spreadsheet.client_encoding = 'UTF-8'
        @book = Spreadsheet::Workbook.new
        @sheet = @book.create_worksheet name: "Data Analysis: #{$DATA_ANALYSIS_NAME}" # the analysis nameshould be an input

      end

      def create_directory(directory_name)
        Dir.mkdir(directory_name) unless File.exists? directory_name
      end

      def create_spreadsheet_report
        create_spreadsheet_header
        create_spreadsheet_body
      end

      def create_spreadsheet_header
        @sheet.row(0).concat $IMDB_ATTRIBUTES_HEADERS

        format = Spreadsheet::Format.new :color => :blue,
                         :weight => :bold,
                         :size => 18
        @sheet.row(0).default_format = format
      end

      # Loop through array of and array imbd data. Each row has the 
      # the information about the film/movie
      # The Data is obtained from MovieDB::Movie
      # example
      # catching fire |
      def create_spreadsheet_body
       $IMDB_ATTRIBUTES_HEADERS.each do |header|
        case header
          when 'title' then spreadsheet_body_text_data("title")
          when 'cast_members' then spreadsheet_body_count_data("cast_members")
          when 'cast_characters' then spreadsheet_body_count_data("cast_characters")
          when 'cast_member_ids' then spreadsheet_body_count_data("cast_member_ids")
          when 'cast_members_characters' then spreadsheet_body_count_data("cast_members_characters")
          when 'trailer_url' then spreadsheet_body_text_data("trailer_url")
          when 'director' then spreadsheet_body_text_data("director")
          when 'writer' then spreadsheet_body_text_data("writer")
          when 'filming_locations' then spreadsheet_body_text_data("filming_locations")
          when 'company' then spreadsheet_body_text_data("company")
          when 'genres' then spreadsheet_body_text_data("genres")
          when 'languages' then spreadsheet_body_text_data("languages")
          when 'countries' then spreadsheet_body_text_data("countries")
          when 'length' then spreadsheet_body_numeric_data("length")
          when 'plot' then spreadsheet_body_text_data("plot")
          when 'poster' then spreadsheet_body_text_data("poster")
          when 'rating' then spreadsheet_body_numeric_data("rating")
          when 'votes' then spreadsheet_body_numeric_data("votes")
          when 'mpaa_rating' then spreadsheet_body_numeric_data("mpaa_rating")
          when 'year' then spreadsheet_body_numeric_data("year")
          when 'release_date' then spreadsheet_body_numeric_data("release_date")
          end
        end
      end

      def spreadsheet_body_text_data(header_title)
        @e_t = element_title = MovieDB::Movie.instance_eval{filter_movie_attr(header_title)}.flatten

        element_title.each_with_index do |element2,i|
          element_array = element_title[(i)].split('   ',)
          @sheet.row(1 + i).concat element_array 
        end
      end

      def spreadsheet_body_count_data(header_title)
         element_cast = MovieDB::Movie.instance_eval{filter_movie_attr(header_title)}

         0.upto(@e_t.length - 1) do |i|
           element_array = []

          element_array << element_cast[i].length
          @sheet.row(1 + i).concat element_array
         end
      end

      def spreadsheet_body_numeric_data(header_title)
        @e_t = element_title = MovieDB::Movie.instance_eval{filter_movie_attr(header_title)}

        element_title.each_with_index do |element2,i|
          element_array = element_title[(i)]
          @sheet.row(1 + i).concat element_array
        end
      end

      def report_name
        name = "Example_Coeffiecient_Of_Determination_".to_s.downcase
        name << "#{Time.now.to_s.gsub(':', '').gsub('-', '').gsub(' ', '').split('')[0..9].join}"
      end

      def write_xls_file
        filename = ("#{report_name}.xls")
        @book.write File.join('reports', filename)
      end

    end
  end
end
