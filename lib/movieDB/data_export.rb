require "spreadsheet"
require "MovieDB"
  
  # This module will write xls document to file
  #
  # Usage @book = Spreadsheet::Workbook.new

module MovieDB
  class DataExport < MovieDB::Movie
    class  << self 
      #TODO: Check the data analysis(DA) name. Write a define_method and include the DA.

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

        title_format = Spreadsheet::Format.new :color => :blue,
                                         :weight => :bold,
                                         :size => 13

        float_format = Spreadsheet::Format.new :number_format => "0.00"

        @sheet.row(0).default_format = title_format
        @sheet.column(1).default_format = float_format
        @sheet.column(16).default_format = float_format
        @sheet.column(22).default_format = float_format
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
          when 'tagline' then spreadsheet_body_text_data("tagline")
          when 'year' then spreadsheet_body_numeric_data("year")
          when 'release_date' then spreadsheet_body_numeric_data("release_date")
          when 'worldwide_gross' then spreadsheet_body_numeric_data("worldwide_gross")
          else
          end
        end
      end

      def spreadsheet_body_text_data(header_title)
        @e_t = element_title = MovieDB::Movie.instance_eval{filter_movie_attr(header_title)}.flatten

        element_title.each_with_index do |element2, i|
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

        element_title.each_with_index do |element2, i|
          element_array = element_title[(i)]
          @sheet.row(1 + i).concat element_array
        end
      end

      def report_name
        name = "imdb_raw_data_".to_s.downcase
        name << "#{Time.now.to_s.gsub(':', '').gsub('-', '').gsub(' ', '').split('')[0..9].join}"
      end

      def write_xls_file
        filename = ("#{report_name}.xls")
        @book.write File.join('reports', filename)
        return filename
      end

    end
  end
end
