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
* Celluloid is used to build fault-tolerant concurrent programs. Note, if you are using MRI or YARV,
multithreading won't work since these types of interpreters have Global Interpreter Lock (GIL).
Fortunately, you can use JRuby or Rubinius, since they don’t have a GIL and support real parallel threading.


## Category

movieDB is broken down into 3 components namely:

* Statistics
* Visualizations
* DataMining

# Statistics

Simple statistical analysis on numeric data.
The corresponding computation is performed on
both numeric and non-mumeric vectors within the
collected data.

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

## Initialize MovieDB (multi-thread setup)

``` ruby
m = MovieDB::Movie.pool(size: 10)
```
## 2 Step Process

Fetching and analysing movie / tv data using movieDB is a simple 2 step process.

First, fetch the data from IMDb.

Next, run your choice of statistic.

That's it! It is that simple.

## Part 1 - Fetch Data from IMDb

There are 2 ways to find IMDb ids.

* Finding specific IMDb ids

* Finding random IMDb ids.

### Fetching specific IMDb ids

To find IMDb id for specific movies, you must go to:

```bash
http://www.imdb.com
```
Search for your movie of choice. Once you do, IMDb redirects you to the movie's page.

The URL for the redirect page includes the IMDB id.

``` ruby
http://www.imdb.com/title/tt0369610/
```
0369610 is the IMDb id.

### Fetching random IMDb ids

``` ruby
r = Random.new
500.times do |i|
  m.async.fetch(("0" + (369000 + r.rand(900)).to_s))
  sleep(20)
end
```
Note that, movieDB will throw an error you randomly generate a wrong IMDb id.

### Get Movie Data (multi-thread setup)

``` ruby
m.async.fetch("0369610", "3079380", "0478970")
```
By calling m.async, this instructs Celluloid that you would like for the given method to be called asynchronously.
This means that rather than the caller waiting for a response of querying both IMDb and TMDb, the caller sends a
message to the concurrent object that you'd like the given method invoked, and then the caller proceeds without waiting for a response.
The concurrent object receiving the message will then process the method call in the background.

Asynchronous calls will never raise an exception, even if an exception occurs when the receiver is processing it.

## Part 2 - Run the statistic.

Below, we've collected 3 specific IMDb ids to use for our statistics examples.

* Ant Man - 0369610
* Jurassic World - 079380
* Spy - 0478970

Finding the Mean value.
```ruby
m.mean
```
Below is the result generated.

```ruby
                             mean
       ant-man  576.8444444444444
jurassic_world  512.5111111111111
           spy 369.73333333333335
```
Below are more statistic methods you can invoke on your objects.

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

### Layout and Template

movieDB allows you to view all your data fields in a worksheetstyle layout.

``` ruby
m.worksheet
```
A total of 45 fields are printed out.

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

In the example above, we've truncated the parts of the results.

## Filters

By default, movieDB processes all values returned from IMDb.
You can customize what fields you want to process with
the following filters:

* only
* except

'only' processes the provided fields you supply.

'Except' is the inverse of 'only.

``` ruby
m.standardize only: [:budget, :revenue, :length, :vote_average]

```
Processes only budget, revenue, length and vote_average values.
``` ruby
              ant-man jurassic_w        spy
    budget 1.49999999 -0.3616594 1.49999999
   revenue -0.5000006 1.49304559 -0.5000013
    length -0.4999988 -0.5656929 -0.4999976
vote_avera -0.5000005 -0.5656931 -0.5000010
```
# Commands

movieDB comes with commands to help you query or manipulate stored objects in redis.

* HGETALL key
Get all the fields and values in a hash of the movie

``` ruby
m.hgetall(["0369610"])
# => {"production_companies"=>"[{\"name\"=>\"Universal Studios\", \"id\"=>13},...}
```
HKEYS key
Get all the fields in a hash of the movie

``` ruby
m.hkeys
# => ["production_companies", "belongs_to_collection", "plot_synopsis", "company", "title",...]
```

HVALS key
Get all the values in a hash of the movie

``` ruby
m.hvals
# => ["[{\"name\"=>\"Universal Studios\", \"id\"=>13}, {\"name\"=>\"Amblin Entertainment\",...]
```

ALL_IDS key
Get all the id of movies

``` ruby
m.all_ids
# => ["0369610", "3079380"...]
```

DELETE_ALL key
deletes all movies stored in redis.

``` ruby
m.delete_all
# => []
```
# Visualizations

This

# DataFrames and Vectors

## Contact me

If you'd like to collaborate, please feel free to fork source code on github.

You can also contact me at albertmck@gmail.com

###### Copyright (c) 2013 - 2015 Albert McKeever, released under MIT license
