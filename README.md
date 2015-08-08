# MovieDB

 MovieDB is a multi-threaded ruby wrapper for fetching raw Movie or TV Data from IMDb and performing a variety of high-level statistics.
 The objective and usage of this tool is to allow media producers to collect raw IMDb data to make logical business decisions.

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
* IMDB IDs can be found at http://www.imdb.com/

## Category
movieDB is broken down into 3 components. They are as follows:

* Statistics
* Visualizations
* DataFrames and Vectors

# Statistics

## Installation

Redis Installation

  This tutorial doesn't cover redis installation.
  You will find that information at: http://redis.io/topics/quickstart


movieDB is available through [Rubygems](http://rubygems.org/gems/movieDB) and can be installed via Gemfile.

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

## Initialize MovieDB

``` ruby
m = MovieDB::Movie.new
```
## General Steps

Fetching and analysing movie / tv data using movieDB is a simple 2 step process.

First, fetch the data from IMDb.

Next, run your choice of statistic.

That's it! It is that simple.

## Part 1 - Fetch Data from IMDb.
The following movie ids are used for our example.

We get that data from http://www.imdb.com

When you search for a movie, IMDb displays a url like this:

``` ruby
http://www.imdb.com/title/tt0369610/
```
0369610 is the IMDB id movieDB uses to fetch data.

Below are some IMDb example we will be using in this tutorial.

* Ant Man - 0369610
* Jurassic World - 079380
* Spy - 0478970

``` ruby
m.fetch("0369610", "3079380", "0478970")
```
## Part 2 - Run the statistic.

Here we use the mean statistic method.

``` ruby
m.mean
```
Below is the result generated.

``` ruby
                             mean
       ant-man  576.8444444444444
jurassic_world  512.5111111111111
           spy 369.73333333333335
```
movieDB provides you with additional statistic methods.

Feel free to try them out.

* std
* sum
* count
* max
* min
* product
* standardize
* describe
* covariance
* correlation

movieDb allows you to view all your fields in a worksheet template style.

``` ruby
m.worksheet
```
Below is the result generated.

``` ruby
              ant-man jurassic_w        spy
production        177        128         40
belongs_to          0        151          0
plot_synop       9083          0       9629
   company         14         18         21
     title          7         14          3
filming_lo        267       1037        530
cast_chara       4094       5894       1001
trailer_ur          0         46         45
cast_membe       2833       3452        939
     votes          5          6          5
     adult          5          5          5
also_known        928       1601       1195
  director         15         19         13
plot_summa        373        298        311
 countries          7         16          7
       ...        ...        ...        ...
```

## Filters

movieDB comes with 2 filters that you to select fields you want to perform statistics on.
* only
* except

Below we find the standard deviation ONLY:

``` ruby
m.std only: [:budget, :revenue, :length, :vote_average]

# =>                             std
           ant-man 64999979.33335541
     jurassic_world 735172842.3334398
               spy 32499978.83337986
```
``` ruby
                            std
      ant-man 64999979.33335541
jurassic_world 735172842.3334398
          spy 32499978.83337986
```


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

# Visualizations

# DataFrames and Vectors
## Contact me

If you'd like to collaborate, please feel free to fork source code on github.

You can also contact me at albertmck@gmail.com

###### Copyright (c) 2013 - 2015 Albert McKeever, released under MIT license

list of available movie attributes
http://www.imdb.com/title/tt0133093/?ref_=fn_al_tt_1