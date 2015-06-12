require 'spec_helper'

describe MovieDB::DataExport do

  describe "#fetch_movie_data_from_imdb" do
      MovieDB::Movie.get_data("2024544", "1800241", "0791314")

      let(:file_name) {MovieDB::Movie.write_imdb_data_to_xls}

    it 'writes the fetched data as an xls file to the reports directory' do
     File.exist?(File.join('reports', file_name)).should == true
    end

  end
end
