require "spreadsheet"

# JSON Data (movie_DS) fetched from IMDb by the movieDB.rb module is processed here.
# Spreadsheet gem is used to writes the attributes in an xls format to the report folder,
# where it is later used for data analysis.
#
# Usage / Example:
#
#   MovieDB::Movie.export_movie_data(IMDB_JSON_FILE)
module MovieDB
  module DataExport
    def export_movie_data(movie_DS)
      @movie_DS = movie_DS
      create_spreadsheet_file
      create_spreadsheet_report(movie_DS)
      write_xls_file
    end

    def create_spreadsheet_file
      directory_name = 'reports'
      create_directory(directory_name)

      Spreadsheet.client_encoding = 'UTF-8'

      @book = Spreadsheet::Workbook.new
      @sheet = @book.create_worksheet
      @sheet.name = report_name if @movie_DS
      @sheet.name = "Data Analysis: #{$DATA_ANALYSIS_NAME}" if $DATA_ANALYSIS_NAME
    end

    def create_directory(directory_name)
      Dir.mkdir(directory_name) unless File.exists? directory_name
    end

    def create_spreadsheet_report(movie_DS)
      create_spreadsheet_header
      create_spreadsheet_body(movie_DS)
    end

    def create_spreadsheet_header
      @sheet.row(0).concat $IMDB_ATTRIBUTES_HEADERS

      title_format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 13
      float_format = Spreadsheet::Format.new :number_format => "0.00"

      @sheet.row(0).default_format = title_format
      @sheet.column(1).default_format = float_format
      @sheet.column(16).default_format = float_format
      @sheet.column(22).default_format = float_format
    end

    # The values from the header_attr is converted from a string to a method.
    # We accomplish this by using Object#send
    #
    # Example Usage:
    #
    #    movie_attribute = movie_DS[i].send(header_attr)
    #
    # Starts the row insert on row 1 and not row 0.
    #
    # Example Usage:
    #
    #   row = @sheet.row(i + 1)
    def create_spreadsheet_body(movie_DS)
      0.upto(movie_DS.length - 1) do |i|
        row = @sheet.row(i + 1)

        $IMDB_ATTRIBUTES_HEADERS.each do |header_attr|
          string_values = ['title', 'language', 'length', 'rating', 'vote', 'release', 'mpaa_rating', 'year']
          movie_attribute = movie_DS[i].send(header_attr)

          row.push(movie_attribute.map { |t| t }.join(' ')) if ([].unshift header_attr).any? { |v| string_values.include?(v) }
          row.push movie_attribute.length if (movie_attribute.is_a? Array) && ([].unshift header_attr).any? { |v| !string_values.include?(v) }
          row.push(movie_attribute) if movie_attribute.is_a? String
        end
      end
    end

    def report_name
      name = "imdb_"

      0.upto(@movie_DS.length - 1) do |i|
        name << @movie_DS[i].title.map { |m| m }.join().gsub(' ', '')
        name << '_' unless i == (@movie_DS.length - 1)
      end

      #name << "#{Time.now.to_s.gsub(':', '').gsub('-', '').gsub(' ', '').split('')[0..7].join}"

      return name
    end

    def write_xls_file
      filename = ("#{report_name}.xls")
      @book.write File.join('reports', filename)

      return filename
    end
  end
end
