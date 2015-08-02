## MovieDB

 MovieDB is a multi-threaded ruby wrapper for fetching raw Movie or TV Data from IMDb and performing a variety of high-level statistics.
 The objective and usage of this tool is to allow media producers to collect raw film data to make logical business decisions.

 SciRuby is the tool used for all statistical and scientific computations.
 Redis is used to store all data with an expiration time of 1800 seconds for all cached objects.
 IMDb is where we collect a chunk of the film data.
 TMDb is where we collect the film revenues.
 BoxOfficeMojo is where we will be scraping future film data.

  - [![PullReview stats](https://www.pullreview.com/github/keeperofthenecklace/movieDB/badges/master.svg?)](https://www.pullreview.com/github/keeperofthenecklace/movieDB/reviews/master)
  - [![Dependency Status](https://gemnasium.com/keeperofthenecklace/movieDB.svg)](https://gemnasium.com/keeperofthenecklace/movieDB)
  - [![Join the chat at https://gitter.im/keeperofthenecklace/movieDB](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/keeperofthenecklace/movieDB?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
  - [![Coverage Status](https://coveralls.io/repos/keeperofthenecklace/movieDB/badge.svg?branch=master&service=github)](https://coveralls.io/github/keeperofthenecklace/movieDB?branch=master)
  - [![Code Climate](https://codeclimate.com/github/keeperofthenecklace/movieDB.png)](https://codeclimate.com/github/keeperofthenecklace/movieDB)
  - [![Gem Version](https://badge.fury.io/rb/movieDB.png)](http://badge.fury.io/rb/movieDB)
  - [![Build Status](https://secure.travis-ci.org/keeperofthenecklace/movieDB.png?branch=master)](http://travis-ci.org/keeperofthenecklace/movieDB)

## Installation

Redis Installation

  This tutorial doesn't cover redis installation.
  You will find that information at: http://redis.io/topics/quickstart

Add this line to your application's Gemfile:

    gem 'movieDB'

And then execute:

    bundle install

Or install it yourself as:

    gem install movieDB

## Require - loading the libraries

    irb

    require 'movieDB'

## Usage - Initialize movieDB

   m = MovieDB::Movie.new

## Usage - Fetch movie data.
   There are several ways to fetch movie data.

    # Fetch using a string in an array.
    m.imdb_id = ["0369610", "3079380"]

    # Fetch using numeric in an array.
    m.imdb_id = [0369610, 3079380]

    # Fetch using sequence strings.
    m.imdb_id = "0369610", 3079380

## Print - Outputting a hash movie data.
    By default When you fetch the movie data, movieDB
    outputs the results as a Hash.

    #

## Print - Outputting a JSON movie data.
    # You can request a JSON with the following command.

      m.imdb_id.to_json

    {
      "adult": false,
      "backdrop_path": "/dkMD5qlogeRMiEixC4YNPUvax2T.jpg",
      "belongs_to_collection": {
        "id": 328,
        "name": "Jurassic Park Collection",
        "poster_path": "/jcUXVtJ6s0NG0EaxllQCAUtqdr0.jpg",
        "backdrop_path": "/pJjIH9QN0OkHFV9eue6XfRVnPkr.jpg"
      },
      "budget": 150000000,
      ...

## Usage - Add, delete Movie IMDb ids
    You can add and delete IMDb ids

    m.unshift('089000')
    m.push('454562')
    m.delete_at(1)

  /* YOU CAN ADD AS MANY IMDB IDs AS YOU LIKE. BUT DO NOT EXCEED THE MAXIMUM REQUEST RATE. */
## Basic functions and Data Analysis:

* Data Analysis
* Exploratory Data Analysis
* Confirmatory Data Analysis
* More to come...

### IMDb Statistics
    Currently, the following statistic can be performed

    `:Median`
    `:Mean`
    `:Mode`
    `:Average`


## Usage - Analyzing Data From IMDb.

    irb

    require 'MovieDB/data_analysis'

    require 'MovieDB/data_process'

    MovieDB::DataProcess.send(:basic_statistic, 'imdb_JurassicWorld_Spy_.xls')

A statistical computation is performed and the results are written in JSON format and stored
  in redis.


You can open movieDB directory from your terminal.

Assuming you are using vim as your IDE,

    EDITOR=vi bundle open movieDB

Inside the reports directory you will find this file.

    Statistic_imdb_JurassicWorld_Spy.xls

## What's Next

##### More statistical computations coming soon:

`:GaussNewtonAlgorithm`
`:EstimationOfDensity`
`:ExploratoryDataAnalysis`

## Contact me

If you'd like to collaborate, please feel free to fork source code on github.

You can also contact me at albertmck@gmail.com

###### Copyright (c) 2013 - 2015 Albert McKeever, released under MIT license
