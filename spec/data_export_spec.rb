require 'spec_helper'

describe MovieDB::DataExport do

  describe "#write_xls_file " do
    imdb_id = ["2024544", "1800241", "0791314"]

    MovieDB::Movie.get_data(imdb_id)

    let(:file_name) { MovieDB::Movie.write_xls_file }

    it 'writes the fetched data as an xls file' do
     expect(File.exist?(File.join('reports', file_name))).to eql(true)
    end
  end
end
