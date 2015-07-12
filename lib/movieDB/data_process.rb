require 'MovieDB/dataanalysis'

module MovieDB
  class DataProcess
    PATHAOV = MovieDB::DataAnalysis::AnalysisOfVariance::LeastSquares
    extend PATHAOV::Statistic
    extend PATHAOV::CoefficientOfDetermination

    include PATHAOV::ExplainedSumOfSquares
    include PATHAOV::FractionOfVarianceUnexplained
    include PATHAOV::GaussNewtonAlgorithm
    include PATHAOV::IterativelyReweightedLeastSquares
    include PATHAOV::LackOfFitSumOfSquares
    include PATHAOV::LeastSquaresSupportVectorMachine
    include PATHAOV::MeanSquaredError
    include PATHAOV::NonLinearIterativePartialLeastSquares
    include PATHAOV::NonLinearLeastSquares
    include PATHAOV::OrdinaryLeastSquares
    include PATHAOV::PartialLeastSquaresRegression
    include PATHAOV::PartitionOfSumsOfSquares
    include PATHAOV::ResidualSumOfSquares
    include PATHAOV::TotalLeastSquares
    include PATHAOV::TotalSumOfSquares
  end
end
