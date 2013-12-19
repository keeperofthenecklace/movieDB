require 'MovieDB/data_analysis'

module MovieDB
  class DataProcess
    PATH_AOV = MovieDB::DataAnalysis::AnalysisOfVariance::LeastSquares
    extend PATH_AOV::Coefficient_Of_Determination
    include PATH_AOV::Explained_Sum_Of_Squares
    include PATH_AOV::Fraction_Of_Variance_Unexplained
    include PATH_AOV::Gauss_Newton_Algorithm
    include PATH_AOV::Iteratively_Reweighted_Least_Squares
    include PATH_AOV::Lack_Of_Fit_Sum_Of_Squares
    include PATH_AOV::Least_Squares_Support_Vector_Machine
    include PATH_AOV::Mean_Squared_Error
    include PATH_AOV::Non_Linear_Iterative_Partial_Least_Squares
    include PATH_AOV::Non_Linear_Least_Squares
    include PATH_AOV::Ordinary_Least_Squares
    include PATH_AOV::Partial_Least_Squares_Regression
    include PATH_AOV::Partition_Of_Sums_Of_Squares
    include PATH_AOV::Residual_Sum_Of_Squares
    include PATH_AOV::Total_Least_Squares
    include PATH_AOV::Total_Sum_Of_Squares
  end
end

