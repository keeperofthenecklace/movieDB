require 'spec_helper'

describe MovieDB::DataProcess do

  describe "#AnalysisOfVariance" do
   describe "#LeastSquares" do
     describe "#Coefficient_Of_Determination" do
        let(:basic_stat) {MovieDB::DataProcess}

        it "should return the cof" do
         basic_stat.send(:basic_statistic, 'imdb_raw_data_2013122109.xls').should == []
        end 

        it "raise error if file does not exist" do

        end
     end

     describe "#Discrete_Least_Squares_Meshless_Method" do
      pending
     end

     describe "#Explained_Sum_Of_Squares" do
      pending
     end 

     describe "#Fraction_Of_Variance_Unexplained" do
      pending
     end

     describe "#Gauss_Newton_Algorithm" do
      pending
     end

     describe "#Iteratively_Reweighted_Least_Squares" do
      pending
     end

     describe "#Lack_Of_Fit_Sum_Of_Squares" do
      pending
     end

     describe "#Least_Squares_Support_Vector_Machine" do
      pending
     end

     describe "#Mean_Squared_Error" do
      pending
     end

     describe "#Moving_Least_Squares" do
      pending
     end

     describe "#Non_Linear_Iterative_Partial_Least_Squares" do
      pending
     end

     describe "#Non_Linear_Least_Squares" do
      pending
     end

     describe "#Ordinary_Least_Squares" do
      pending
     end

     describe "#Partial_Least_Squares_Regression" do
      pending
     end

     describe "#Partition_Of_Sums_Of_Squares" do
      pending
     end

     describe "#Proofs_Involving_Ordinary_Least_Squares" do
      pending
     end

     describe "#Residual_Sum_Of_Squares" do
      pending
     end

     describe "#Total_Least_Squares" do
      pending
     end

     describe "#Total_Sum_Of_Squares" do
      pending
     end
   end
  end

  describe "#EstimationOfDensity" do

  end

  describe "#ExploratoryDataAnalysis" do
   pending
  end

  describe "#DataMining" do
   pending
  end

  describe "RegressionAnalysis" do
   pending
  end

 describe "#Resampling" do
   pending
 end

 describe "#Sensitivity_Analysis" do
   pending
 end 

 describe "#Time_series_Analysis" do
   pending
 end
end
