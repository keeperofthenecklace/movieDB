 MovieDB - Movie Data Analysis Tool

## Description

Although the name suggests a datastore gem, MovieDB is actually a ruby wrapper that inspects, cleans, transform and model imdb data and provides useful data analysis information, suggesting conclusion.  The objective and usage is to provide a tool that can aide movie/film producers make statistical decisions based off archival imdb data.

Basic functions and Data Analysis:
* Data Analysis
* Exploratory Data Analysis
* Confirmatory Data Analysis

## Requirements
  
    ruby 1.9.x

## Installation

Add this line to your application's Gemfile:

    gem 'movieDB'

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install movieDB

## Usage - Collecting Movie Data From IMDb

    $ irb

    > require 'movieDB'
   
    > require 'MovieDB/data_export'

    > MovieDB::Movie.clear_data_store  **ONLY IF YOUR WANT TO EMPTY YOUR DATASTORE (ARRAY)
  
    > MovieDB::Movie.send(:get_multiple_imdb_movie_data, "2024544", "1800241", "0791314")  

      ** YOU CAN ADD AS MANY IMDB UNIQUE NUMBERS. JUST DO NOT EXCEED MAXIMUM REQUEST RATE.

    > MovieDB::DataExport.export_movie_data

## Exported Document

The exported movie data is stored in your reports directory.

    $ cd /reports/imdb_raw_data_20131216.xls

## Usage - Analysing Data and Generating Stats

    $ irb

    > require 'MovieDB/data_analysis'

    > require 'MovieDB/data_process'

    > MovieDB::DataProcess.send(:basic_statistics, 'imdb_raw_data_20131216.xls')

## Exported - Analyzed Data 

The exported analyzed data is stored in your reports directory.

    $ cd /reports/basic_statistic_20131216.xls

## What's Next

 More statistical computations coming. This includes:

    > GaussNewtonAlgorithm 
      > Iteratively_Reweighted_Least_Squares 
      > Lack_Of_Fit_Sum_Of_Squares 
      > Least_Squares_Support_Vector_Machine 
      > Mean_Squared_Error 
      > Moving_Least_Sqares 
      > Non_Linear_Iterative_Partial_Least_Squares 
      > Non_Linear_Least_Squares 
      > Ordinary_Least_Squares 
      > Partial_Least_Squares_Regression 
      > Partition_Of_Sums_Of_Squares 
      > Proofs_Involving_Ordinary_Least_Squares 
      > Residual_Sum_Of_Squares 
      > Total_Least_Squares 
      > Total_Sum_Of_Squares 
    
    > EstimationOfDensity
      > Cluster_Weighted_Modeling 
      > Density_Estimation 
      > Discretization_Of_Continuous_Features 
      > Mean_Integrated_Squared_Error 
      > Multivariate_Kernel_Density_Estimation 
      > Variable_Kernel_Density_Estimation 
    
    > ExploratoryDataAnalysis
      > Data_Reduction 
      > Table_Diagonalization 
      > Configural_Frequency_Analysis 
      > Median_Polish 
      > Stem_And_Leaf_Display 
    
    > Data_Mining
      > Applied_DataMining 
      > Cluster_Analysis 
      > Dimension_Reduction 
      > Applied_DataMining 
    
    > RegressionAnalysis
      > Choice_Modelling 

      > Generalized_Linear_Model 
        > Binomial_Regression         
        > Generalized_Additive_Model         
        > Linear_Probability_Model         
        > Poisson_Regression         
        > Zero_Inflated_Model            
      
      > Nonparametric_Regression 
      > Statistical_Outliers 
      > Regression_And_Curve_Fitting_Software 
      > Regression_Diagnostics 
      > Regression_Variable_Selection 
      > Regression_With_Time_Series_Structure 
      > Robust_Regression 
      > Choice_Modeling 
    
    > Resampling
      > Bootstrapping_Population 
    
    > Sensitivity_Analysis
      > Variance_Based_Sensitivity_Analysis 
      > Elementary_Effects_Method 
      > Experimental_Uncertainty_Analysis 
      > Fourier_Amplitude_Sensitivity_Testing 
      > Hyperparameter 
    
    > Time_Series_Analysis
      > Frequency_Deviation 

## Contact me

If you'd like to collaborate, please feel free to fork source code on github. 

You can also contact me at albertmck@gmail.com

     
