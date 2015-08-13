require 'spec_helper'
require 'MovieDB'

describe MovieDB do
  describe "#ids_to_array" do

    let(:m) { MovieDB::Movie.new }

    context "When fetching movie data" do
      it "takes a string value and converts it to an array." do
        expect(m.ids_to_array("0369610")).to eql(["0369610"])
      end

      it "takes a numeric value and converts it to an array." do
        expect(m.ids_to_array(3079380)).to eql(["3079380"])
      end

      it "keeps a numeric value in an array." do
        expect(m.ids_to_array(["3079380"])).to eql(["3079380"])
      end
    end
  end
end
