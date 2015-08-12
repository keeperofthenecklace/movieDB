require 'spec_helper'
require 'MovieDB'

describe MovieDB do
  describe "#ids_to_array" do

    let(:m) { MovieDB::Movie.new }

    context "When fetching movie data" do
    #   it "takes a string value and converts it to an array." do
    #     expect(m.ids_to_array("0369610")).to eql(["0369610"])
    #   end
    #
    #   it "takes a numeric value and converts it to an array." do
    #     expect(m.ids_to_array(3079380)).to eql(["3079380"])
    #   end
    #
    #   it "keeps a numeric value in an array." do
    #     expect(m.ids_to_array(["3079380"])).to eql(["3079380"])
    #   end

      it 'abc' do
        m.fetch("0369610", "3079380", "0478970")
        expect(m.standardize only: [:budget, :revenue, :length, :vote_average]).to eq ([])
      end
    end
  end
end
