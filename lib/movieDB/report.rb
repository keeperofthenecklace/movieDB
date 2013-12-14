require "spreadsheet"

  # The module will write xls document to file
  #
  # Usage @book = Spreadsheet::Workbook.new

module MovieDb
  class DataExport < ::Movie::DataAnalysis

    #TODO: Check the data analysis type
    # perform 
    def generate(data_analysis_after_proc)
     create_file
     create_report
     write_file
    end

    private

      def create_file
        directory = ('reports')
        create_directory(directory)
        @book = Spreadsheet::Workbook.new
        @sheet = @book.create_worksheet name: "Data Analysis: #{$data_analysis_name}"
      end

      def create_directory(directory_name)
        Dir.mkdir(directory_name) unless File.exists? directory_name
      end

      def create_report
        create_header
        create_body
      end

      def create_header
        @sheet.row(0).concat %w($data_headers)
      end

      def create_body

      end

      def write_file
        self.filename = ("/reports/#{report_name}.xls")
        @book.write(self.filename)
      end

      def report_name
        name = self.type.to_s.downcase
        name << "#{Time.now.to_s.gsub(':', '').gsub('-', '').gsub(' ', '').split('')[0..9].join}"
      end
  end
end
