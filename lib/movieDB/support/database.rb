# This setup connects to the database
# using Active-Record.
#
# Create a database called 'yearly_domestic_grosses
# Add the follow ing attributes:
#   :title, :studio, :total_gross, :theaters, :opening, :year

require 'active_record'
require 'mysql2' # or 'pg' or 'sqlite3'

module MovieDB
  module Support
    module Database
      class YearlyDomesticGross < ActiveRecord::Base

        def initialize
          ActiveRecord::Base.establish_connection(
              adapter:  'mysql2', # or 'postgresql' or 'sqlite3'
              database: 'movieDB',
              username: 'root',
              password: '',
              host:     '127.0.0.1'
          )
        end


        # Fetch data from Kimonolabs endpoint.
        def api_connect
          response = RestClient.get 'https://www.kimonolabs.com/api/chlrt5sq?apikey=m9VP32kuvgnuVGS9fXOa2tsP0xEj5zbu'
        end

        # Persist the data to the database
        def save
          JSON.parse(response)['results']['domestic_gross'].each do |e|
            if e['title']['text'] != 'Movie Title (click to view)'
              title = e['title']['text']
              studio = e['studio']['text']
              total_gross = e['total_gross'].gsub('$','').gsub(',','').to_i
              theaters = e['theaters'].gsub(',','').to_i
              opening = e['opening'].gsub('$','').gsub(',','').to_i
              year = 2012
              YearlyDomesticGross.create(title: title, studio: studio, total_gross: total_gross, theaters: theaters, opening: opening, year: year)
            end
          end
        end

      end
    end
  end
end


p MovieDB::Support::Database::YearlyDomesticGross.new
