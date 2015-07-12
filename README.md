## MovieDB

 MovieDB is a ruby wrapper for fetching raw Movie or TV Data from IMDb and performing a variety of statistical analysis and computation.
 The objective and usage of this tool is to help media producers make high level structured decisions based on realistic analysis of actual data.

 The fetched data is stored in memory using Redis and has an expiration time of 1800 seconds for all cached objects.

  - [![PullReview stats](https://www.pullreview.com/github/keeperofthenecklace/movieDB/badges/master.svg?)](https://www.pullreview.com/github/keeperofthenecklace/movieDB/reviews/master)
  - [![Dependency Status](https://gemnasium.com/keeperofthenecklace/movieDB.svg)](https://gemnasium.com/keeperofthenecklace/movieDB)
  - [![Join the chat at https://gitter.im/keeperofthenecklace/movieDB](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/keeperofthenecklace/movieDB?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
  - [![Coverage Status](https://coveralls.io/repos/keeperofthenecklace/movieDB/badge.svg)](https://coveralls.io/r/keeperofthenecklace/movieDB)
  - [![Code Climate](https://codeclimate.com/github/keeperofthenecklace/movieDB.png)](https://codeclimate.com/github/keeperofthenecklace/movieDB)
  - [![Gem Version](https://badge.fury.io/rb/movieDB.png)](http://badge.fury.io/rb/movieDB)
  - [![Build Status](https://secure.travis-ci.org/keeperofthenecklace/movieDB.png?branch=master)](http://travis-ci.org/keeperofthenecklace/movieDB)

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
`:EstimationOfDensity`
`:ExploratoryDataAnalysis`

## Contact me

If you'd like to collaborate, please feel free to fork source code on github.

You can also contact me at albertmck@gmail.com

###### Copyright (c) 2013 Albert McKeever, released under MIT license
