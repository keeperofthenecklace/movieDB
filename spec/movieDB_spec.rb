require 'spec_helper'

describe MovieDB do
  describe "#find_imdb_id" do
    m = MovieDB::Movie.new

    it "fetches data from IMDb" do
      expect(m.title).to eql "Method Missing 2: Rails Roars!"
    end
  end
end
