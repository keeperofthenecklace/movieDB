# MovieDB

 MovieDB is a multi-threaded ruby wrapper for fetching raw Movie or TV Data from IMDb and performing a variety of high-level statistics.
 The objective and usage of this tool is to allow media producers to collect raw film data to make logical business decisions.

## Badges
  - [![PullReview stats](https://www.pullreview.com/github/keeperofthenecklace/movieDB/badges/master.svg?)](https://www.pullreview.com/github/keeperofthenecklace/movieDB/reviews/master)
  - [![Dependency Status](https://gemnasium.com/keeperofthenecklace/movieDB.svg)](https://gemnasium.com/keeperofthenecklace/movieDB)
  - [![Join the chat at https://gitter.im/keeperofthenecklace/movieDB](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/keeperofthenecklace/movieDB?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
  - [![Coverage Status](https://coveralls.io/repos/keeperofthenecklace/movieDB/badge.svg?branch=master&service=github)](https://coveralls.io/github/keeperofthenecklace/movieDB?branch=master)
  - [![Code Climate](https://codeclimate.com/github/keeperofthenecklace/movieDB.png)](https://codeclimate.com/github/keeperofthenecklace/movieDB)
  - [![Gem Version](https://badge.fury.io/rb/movieDB.png)](http://badge.fury.io/rb/movieDB)
  - [![Build Status](https://secure.travis-ci.org/keeperofthenecklace/movieDB.png?branch=master)](http://travis-ci.org/keeperofthenecklace/movieDB)

## Technology
* SciRuby is the tool used for all statistical and scientific computations.
* Redis is used to store all data with an expiration time of 1800 seconds for all cached objects.
* IMDb is where we collect a chunk of the film data.
* TMDb is where we collect the film revenues.
* BoxOfficeMojo is where we will be scraping future film data.

## Installation

Redis Installation

  This tutorial doesn't cover redis installation.
  You will find that information at: http://redis.io/topics/quickstart


movieDB is available through [Rubygems](http://rubygems.org/gems/movieDB) and can be installed via:

Add this line to your application's Gemfile:

``` ruby
gem 'movieDB'
```

And then execute:

``` ruby
$ bundle install
```

Or install it yourself as:

``` ruby
gem install movieDB
```

## Console - loading the libraries

``` bash
$ irb
```

## Require the gem

```ruby
require 'movieDB'
```

## Usage - Add movie data.

There are several ways to add movie data.
Initial redis.

``` ruby
m = MovieDB::Movie.new
```
Add using a string objects in an array.
``` ruby
m.imdb_id = ["0369610", "3079380"]
```

Add using numeric objects in an array.
``` ruby
m.imdb_id = [0369610, 3079380]
```

Add using mixed values.
``` ruby
m.imdb_id = "0369610", 3079380
```

## Usage - Query data
Fetch all imdb ids in your redis database

``` ruby
m = MovieDB::Movie.new

m.all_ids
# => ["0369610", "3079380"]
```

Delete all imdb ids in your redis database

``` ruby
m.delete_all
# => []
```

## Printing document.

By default when you fetch the movie data, movieDB
prints the results to screen as Hash.

``` ruby
    {"adult"=>false, "backdrop_path"=>"/dkMD5qlogeRMiEixC4YNPUvax2T.jpg",
    "belongs_to_collection"=>{"id"=>328,
    "name"=>"Jurassic Park Collection",
    "poster_path"=>"/jcUXVtJ6s0NG0EaxllQCAUtqdr0.jpg",
    "backdrop_path"=>"/pJjIH9QN0OkHFV9eue6XfRVnPkr.jpg"},
    ...
```

You can have movieDB print out your results to screen as JSON.

``` ruby
m.find = ["0369610"]

m.json

```
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

## Print - Outputting an XML movie data.
    # You can have movieDB print out your results
     to screen as XML.

        m = MovieDB::Movie.new

        m.imdb_id = ["0369610", "3079380"]

        m.xml

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
