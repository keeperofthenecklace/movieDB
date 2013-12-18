require 'spec_helper'

describe MovieDB::DataExport do
  
  describe "#export_movie_data" do
      MovieDB::Movie.send(:clear_data_store)
      MovieDB::Movie.send(:get_multiple_imdb_movie_data, "2024544", "1800241", "0791314")
      MovieDB::DataExport.export_movie_data

      let(:file_name) {MovieDB::DataExport.write_xls_file}

    it 'writes the exported data as an xls file to the reports directory' do
     File.exist?(File.join('reports', file_name)).should == true
    end

  end
end
