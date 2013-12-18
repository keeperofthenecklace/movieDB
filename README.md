 MovieDB - Movie Data Analysis Tool

## Description

Although the name suggests a datastore gem, MovieDB is actually a ruby wrapper that inspects, cleans, transform and model imdb data and provides useful data analysis information, suggesting conclusion.  The objective is provide a tool that will help movie/film producers make decisions based on archival imdb data.

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
  
    > MovieDB::Movie.send(:get_multiple_imdb_movie_data, "2024544", "1800241", "0791314")

    > MovieDB::DataExport.export_movie_data

## Exported Document

The excel document is stored in the reports directory.

  $ cd /reports/data_analysis_20131203.xls

## Usage - Data Analysis

  $ wip

