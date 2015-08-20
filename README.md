# MovieDB

 MovieDB is a multi-threaded ruby wrapper for performing advance statistical computation and high-level data analysis on Movie or TV Data from IMDb.
 The objective and usage of this tool is to allow producers, directors, writers to make logical business decisions that will generate profitable ROI.

## Badges
  - [![PullReview stats](https://www.pullreview.com/github/keeperofthenecklace/movieDB/badges/master.svg?)](https://www.pullreview.com/github/keeperofthenecklace/movieDB/reviews/master)
  - [![Dependency Status](https://gemnasium.com/keeperofthenecklace/movieDB.svg)](https://gemnasium.com/keeperofthenecklace/movieDB)
  - [![Join the chat at https://gitter.im/keeperofthenecklace/movieDB](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/keeperofthenecklace/movieDB?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
  - [![Coverage Status](https://coveralls.io/repos/keeperofthenecklace/movieDB/badge.svg?branch=master&service=github)](https://coveralls.io/github/keeperofthenecklace/movieDB?branch=master)
  - [![Code Climate](https://codeclimate.com/github/keeperofthenecklace/movieDB.png)](https://codeclimate.com/github/keeperofthenecklace/movieDB)
  - [![Gem Version](https://badge.fury.io/rb/movieDB.png)](http://badge.fury.io/rb/movieDB)
  - [![Build Status](https://secure.travis-ci.org/keeperofthenecklace/movieDB.png?branch=master)](http://travis-ci.org/keeperofthenecklace/movieDB)

## Technology
* SciRuby is used for all statistical and scientific computations.
* Redis is used to store all data.
* IMDb and TMDb is the source for all film / TV data.
* BoxOfficeMojo is where we will be scraping future film / TV data.
* Celluloid is used to build the fault-tolerant concurrent programs. Note, if you are using MRI or YARV,
multi-threading won't work since these types of interpreters have Global Interpreter Lock (GIL).
Fortunately, you can use JRuby or Rubinius, since they don’t have a GIL and support real parallel threading.

## Requirements
ruby-2.2.2 or higher

jruby-9.0.0.0

## Category
movieDB is broken down into 3 components namely:

* Statistics
* Visualizations (Work in progress)
* DataMining (Work in progress)

# Statistics

Simple statistical analysis on numeric data.
The corresponding computation is performed on
both numeric and string vectors within the
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
m = MovieDB::Movie.pool(size: 2)
```
## Step Process

Fetching and analysing movie / TV data using movieDB is a simple 2 step process.

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

### Fetching random IMDb ids (multi-thread setup)
You can fetch IMDb ids random.

``` ruby
r = Random.new

39.times do |i|
  m.async.fetch(sprintf '%07d', r.rand(300000))
  sleep(4)
end

sleep(10)
```
Note: IMDB has a rate limit of 40 requests every 10 seconds and are limited by IP address, not API key.
If you exceed the limit, you will receive a 429 HTTP status with a 'Retry-After' header.
As soon your cool down period expires, you are free to continue making requests.

Also, movieDB will throw a NameError if the randomly generated IMDb id is invalid.

### Get Movie Data

``` ruby
m.async.fetch("0369610", "3079380", "0478970")
```
By calling m.async, this instructs Celluloid that you would like for the given method to be called asynchronously.
This means that rather than the caller waiting for a response of querying both IMDb and TMDb, the caller sends a
message to the concurrent object that you'd like the given method invoked, and then the caller proceeds without waiting for a response.
The concurrent object receiving the message will then process the method call in the background.

Asynchronous calls will never raise an exception, even if an exception occurs when the receiver is processing it.

### Redis - caching objects

By default, any movie fetched from IMDb is stored in redis and has an expiration time of 1800 seconds (30 minutes).

But you can change this expiration time.

```ruby
m.async.fetch("0369610", "3079380", expire: 86400)
```
Here, I set the expiration time to 86400 seconds which is equivalent to 24 hours.

## Part 2 - Run the statistic

Below, we've collected 3 specific IMDb ids to analyze.

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

movieDB allows you to view all your data fields in a worksheet style layout.

``` ruby
m.worksheet
```
A total of 45 fields are printed out. But, we've truncated the result for ease of reading.


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

When performing statistics on an object, movieDB by default processes all fields.

However, you now have the option of filtering what fields you want processed using the following filters:

* only
* except

'only' analyzes the fields you provide.

'Except' is the inverse of 'only'. It analyzes all the fields you did not provide.

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
* HKEYS key
Get all the fields in a hash of the movie

``` ruby
m.hkeys
# => ["production_companies", "belongs_to_collection", "plot_synopsis", "company", "title",...]
```

* HVALS key
Get all the values in a hash of the movie

``` ruby
m.hvals
# => ["[{\"name\"=>\"Universal Studios\", \"id\"=>13}, {\"name\"=>\"Amblin Entertainment\",...]
```

* ALL_IDS key
Get all the id of movies

``` ruby
m.all_ids
# => ["0369610", "3079380"...]
```

* TTL key
Gets the remaining time to live of a movie.

``` ruby
m.ttl("0369610)
# => 120
```

* DELETE_ALL key
deletes all movie objects stored in redis.

``` ruby
m.delete_all
# => []
```
# Visualizations

* Initialize MovieDB (multi-thread setup)

``` ruby
m = MovieDB::Movie.pool(size: 2)
```

* Get Movie Data

``` ruby
m.async.fetch("0369610", "3079380", "0478970")
```
* Run the statistics

```ruby
m.mean only: [:length, :vote_average]
```
* Plot graph chart

```ruby
m.graph(type: :bar, name: 'vote_length')
```

When plotting a graph, you need specify the type and the name you wish to save the file.

In the example below, we graph a Bar Chart and save it as vote_length.

The file is saved as a HTML document in your local directory.

![Alt text](https://github.com/keeperofthenecklace/movieDB/blob/master/images/sampbar.png?raw=true "Bar Graph")

Below are more graph types you can plot on your objects.

* Bar
* Line
* Scatter + Line
* Histogram
* Box plot
* 2D- Histogram

# Data mining
(Work in progress)

## Contact me

If you'd like to collaborate, please feel free to fork source code on github.

You can also contact me at albertmck@gmail.com

## Disclaimer
This software is provided “as is” and without any express or implied warranties, including, without limitation, the implied warranties of merchantibility and fitness for a particular purpose.

###### Copyright (c) 2013 - 2015 Albert McKeever, released under MIT license
