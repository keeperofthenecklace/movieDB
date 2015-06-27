require "spreadsheet"
require "redis"
require "json"

# Movie data fetched from IMDb is stored as a hash data type in redis.
# The key and values are written into a spreadsheet for later data analysis.
module MovieDB
  module DataExport
    IMDB_ATTRIBUTES_HEADERS = %w(title cast_members cast_characters cast_member_ids cast_members_characters
                    trailer_url director writers filming_locations company genres languages countries
                    length plot poster rating votes mpaa_rating tagline year release_date revenue)

    def export_movie_data(db_redis, imdb_ids)

      @db_redis = db_redis
      @imdb_ids = imdb_ids

      create_spreadsheet_file
      create_spreadsheet_report

      write_xls_file
    end

    def create_spreadsheet_file
      directory_name = 'reports'
      create_directory(directory_name)

      Spreadsheet.client_encoding = 'UTF-8'

      @book = Spreadsheet::Workbook.new
      @sheet = @book.create_worksheet
      @sheet.name = report_name if @db_redis
      @sheet.name = "Data Analysis: #{$DATA_ANALYSIS_NAME}" if $DATA_ANALYSIS_NAME
    end

    def create_directory(directory_name)
      Dir.mkdir(directory_name) unless File.exists? directory_name
    end

    def create_spreadsheet_report
      create_spreadsheet_header
      create_spreadsheet_body
    end

    def create_spreadsheet_header
      @sheet.row(0).concat MovieDB::DataExport::IMDB_ATTRIBUTES_HEADERS

      title_format = Spreadsheet::Format.new :color => :blue, :weight => :bold, :size => 13
      float_format = Spreadsheet::Format.new :number_format => "0.00"

      @sheet.row(0).default_format = title_format
      @sheet.column(1).default_format = float_format
      @sheet.column(16).default_format = float_format
      @sheet.column(22).default_format = float_format
    end

    # We write the all keys and values from our data set to the spreadsheet
    def create_spreadsheet_body
      @imdb_ids.each_with_index do |imdb_id, idx|
        row = @sheet.row(idx + 1)

        MovieDB::DataExport::IMDB_ATTRIBUTES_HEADERS.each do |attr_key|
          string_values = ['title', 'language', 'length', 'rating', 'vote', 'release', 'mpaa_rating', 'year', 'revenue']

          # Check to see if the fetch redis value is in a JSON
          begin
            movie_value = JSON.parse(@db_redis.hget "movie:#{imdb_id}", "#{attr_key}")
          rescue => e
            movie_value = [] << (@db_redis.hget "movie:#{imdb_id}", "#{attr_key}")
          end

          row.push(movie_value.map { |t| t }.join(' ')) if ([].unshift attr_key).any? { |v| string_values.include?(v) }
          row.push movie_value.length if (movie_value.is_a? Array) && ([].unshift attr_key).any? { |v| !string_values.include?(v) }
          row.push(movie_value) if movie_value.is_a? String
        end
      end
    end

    def report_name
      name = "imdb_"

      @imdb_ids.each do |imdb_id|
        name << (@db_redis.hget "movie:#{imdb_id}", "title").gsub(' ', '')
        name << '_' unless @imdb_ids.length == imdb_id
      end

      return name
    end

    def write_xls_file
      filename = ("#{report_name}.xls")
      @book.write File.join('reports', filename)
      return filename
    end
  end
end
