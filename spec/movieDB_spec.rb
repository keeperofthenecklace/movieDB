require 'spec_helper'
require 'MovieDB'

describe MovieDB do
  describe "#imdb=" do
    let(:m) { MovieDB::Movie.new }

    it "should return data from imdb" do

    end

    it "should raise error if id is invalid" do

    end

    it "should return TV data" do

    end

    it "should return Movie data" do

    end

    it "return true if imdb ids are stored" do
      ids = [ "3079380", "0369610", "0133093"]

      expect(m.imdb_id=ids).to be_truthy
    end

    it "raise an error if imdb id doesn't exist" do
      ids = [ "0001W", "0002W", "0003T"]
      expect { m.imdb_id=ids }.to raise_error
    end
  end
end
