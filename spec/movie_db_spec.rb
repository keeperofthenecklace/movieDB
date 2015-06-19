require 'spec_helper'

describe MovieDB::Movie do
  describe "#get_data" do
    let(:file_name) { MovieDB::Movie.get_data('0369610') }

    it "Should return an error if field attribute is not present" do
      expect { MovieDB::Movie.get_data() }.to raise_error
    end

    it "should get data and write xls file" do
      expect(file_name).to eq 'imdb_JurassicWorld_.xls'
    end
  end
end
