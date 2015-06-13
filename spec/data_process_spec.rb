require 'spec_helper'

describe MovieDB::DataProcess do

  describe "#AnalysisOfVariance" do
   describe "#LeastSquares" do
     describe "#Coefficient_Of_Determination" do
        let(:basic_stat) {MovieDB::DataProcess}

        it "should return the cof" do
          # pending
         basic_stat.send(:basic_statistic, 'imdb_12YearsaSlave_AmericanHustle_KeeperoftheNecklace.xls').should == 'Statistic_2015061319.xls'
        end
      end
    end
  end
end
