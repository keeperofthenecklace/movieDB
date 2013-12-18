require 'spec_helper'
require 'imdb' 
require "zimdb"


describe MovieDB do

  describe "#get_imdb_movie_data" do
     context  "Get multiple movie data from IMDb" do
    #
      MovieDB::Movie.send(:clear_data_store)
      MovieDB::Movie.send(:get_multiple_imdb_movie_data, "2024544", "1800241", "0791314")
      MovieDB::DataExport.export_movie_data


       it "Should return titles of movies" do
        MovieDB::Movie.instance_eval{filter_movie_attr("title")}.should == [["12 Years a Slave"], ["American Hustle"], ["Keeper of the Necklace"]]
       end

       it "Should return directors movies" do
        MovieDB::Movie.instance_eval{filter_movie_attr("director")}.should == [["Steve McQueen"], ["David O. Russell"], ["Albert McKeever"]]
       end
    end
  end

  describe "validation" do
    context "invalid id number" do

      it "should raise an error" do
        expect {MovieDB::Movie.send(:get_multiple_imdb_movie_data, "9024544")}.to raise_error('invalid imbd id')
      end
    end
  end
end
