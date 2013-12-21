require 'spec_helper'
require 'imdb' 
require "zimdb"


describe MovieDB do

  describe "#get_imdb_movie_data" do
     
    context  "Get multiple movie data from IMDb" do
    #
     
      MovieDB::Movie.send(:clear_data_store)
      MovieDB::Movie.send(:get_multiple_imdb_movie_data, "0120338", "0120815", "0120915")
      MovieDB::DataExport.export_movie_data


       it "Should return titles" do
        MovieDB::Movie.instance_eval{filter_movie_attr("title")}.should == [["Titanic"], ["Saving Private Ryan"], ["Star Wars: Episode I - The Phantom Menace"]]
       end

       it "Should return directors" do
        MovieDB::Movie.instance_eval{filter_movie_attr("director")}.should == [["James Cameron"], ["Steven Spielberg"], ["George Lucas"]]
       end
    end
  end

  describe "validation" do

    context "invalid id number" do

      it "should raise an error" do
       # expect {MovieDB::Movie.send(:get_multiple_imdb_movie_data, "9024544")}.to raise_error('invalid imbd id')
      end
    end
  end
end
