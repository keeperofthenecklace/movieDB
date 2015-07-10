## MovieDB

 MovieDB is a ruby wrapper for fetching raw Movie or TV Data from IMDb and performing a variety of statistical analysis and computation.
 The objective and usage of this tool is to help media producers make high level structured decisions based on realistic analysis of actual data.

 The fetched data is stored in memory using Redis and has an expiration time of 1800 seconds for all cached objects.

  - [![Join the chat at https://gitter.im/keeperofthenecklace/movieDB](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/keeperofthenecklace/movieDB?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
  - [![Coverage Status](https://coveralls.io/repos/keeperofthenecklace/movieDB/badge.svg)](https://coveralls.io/r/keeperofthenecklace/movieDB)
  - [![Code Climate](https://codeclimate.com/github/keeperofthenecklace/movieDB.png)](https://codeclimate.com/github/keeperofthenecklace/movieDB)
  - [![Gem Version](https://badge.fury.io/rb/movieDB.png)](http://badge.fury.io/rb/movieDB)
  - [![Build Status](https://secure.travis-ci.org/keeperofthenecklace/movieDB.png?branch=master)](http://travis-ci.org/keeperofthenecklace/movieDB)
  - [![PullReview stats](https://www.pullreview.com/github/keeperofthenecklace/movieDB/badges/master.svg?)](https://www.pullreview.com/github/keeperofthenecklace/movieDB/reviews/master)

## Basic functions and Data Analysis:

* Data Analysis
* Exploratory Data Analysis
* Confirmatory Data Analysis
* More to come...

## Installation

Please make sure you have redis installed.

    This tutorial doesn't cover redis installation.

Add this line to your application's Gemfile:

    gem 'movieDB'

And then execute:

    $> bundle install

Or install it yourself as:

    $> gem install movieDB

## Require - loading the libraries

    $> irb

    $> require 'movieDB'

## Usage - Fetch Raw Movie Data From IMDb

    $> imdb_ids = ["0369610", "3079380"]

    $> MovieDB::Movie.find_imdb_id(imdb_ids)

      /* YOU CAN ADD AS MANY IMDB IDs AS YOU LIKE. BUT DO NOT EXCEED THE MAXIMUM REQUEST RATE. */

### IMDb Data

When IMDb data is fetched, two things happen.

First, a reports folder is created in the movieDB gem folder.

Next, the fetched data is written to an xls format and stored in the reports directory.

From your terminal you can locate movieDB gem directory like this:

    $ gem content movieDB

If you use our above IMDb id, you should find the following xls file.

Feel free to open it.

    $ open ../reports/imdb_JurassicWorld_Spy_.xls

## Usage - Analyzing Data From IMDb.

    $ irb

    > require 'MovieDB/data_analysis'

    > require 'MovieDB/data_process'

    > MovieDB::DataProcess.send(:basic_statistic, 'imdb_JurassicWorld_Spy_.xls')

A statistical computation is performed and the results is written to movieDB gem reports folder.

Feel free to open it.

    $ open ../reports/Statistic_imdb_JurassicWorld_Spy.xls

## What's Next

##### More statistical computations coming soon:

`:GaussNewtonAlgorithm`

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

`:EstimationOfDensity`

    > Cluster_Weighted_Modeling
    > Density_Estimation
    > Discretization_Of_Continuous_Features
    > Mean_Integrated_Squared_Error
    > Multivariate_Kernel_Density_Estimation
    > Variable_Kernel_Density_Estimation

`:ExploratoryDataAnalysis`

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

###### Copyright (c) 2013 Albert McKeever, released under MIT license
