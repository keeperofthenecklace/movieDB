require 'spec_helper'
require 'imdb' 
require "zimdb"


describe MovieDB do

  describe "#get_imdb_movie_data" do
    let(:movie_info){ MovieDB::Movie.send(:get_imdb_movie_data, "1951264") }

    context  "query imdb" do
      it "returns movie data from imdb" do
        movie_info.title.should == "The Hunger Games: Catching Fire"
        movie_info.cast_members[0, 4].should == ["Jennifer Lawrence", "Liam Hemsworth", "Jack Quaid", "Taylor St. Clair"]
        movie_info.cast_member_ids[0, 4].should == ["nm2225369", "nm2955013", "nm4425051", "nm1193262"] 
        movie_info.cast_characters[0, 4].should == ["Katniss Everdeen", "Gale Hawthorne", "Marvel", "Ripper"]
        movie_info.cast_members_characters[0, 4].should == ["Jennifer Lawrence => Katniss Everdeen", "Liam Hemsworth => Gale Hawthorne", "Jack Quaid => Marvel", "Taylor St. Clair => Ripper"] 
        movie_info.trailer_url.should == "http://imdb.com/video/screenplay/vi365471769/"
        movie_info.director.should == ["Francis Lawrence"]
        #movie_info.writer.should == "Simon Beaufoy, Michael Arndt"
        movie_info.filming_locations[0, 2].should == ["Oakland, New Jersey, USA", "O'ahu, Hawaii, USA"]
        movie_info.company.should == "Color Force"
        movie_info.genres.should == ["Action", "Adventure", "Sci-Fi", "Thriller"]
        movie_info.languages.should == ["English"]
        movie_info.countries.should == ["USA"]
        movie_info.length.should == 146
        movie_info.plot.should == "Katniss Everdeen and Peeta Mellark become targets of the Capitol after their victory in the 74th Hunger Games sparks a rebellion in the Districts of Panem."
        movie_info.poster.should == "http://ia.media-imdb.com/images/M/MV5BMTAyMjQ3OTAxMzNeQTJeQWpwZ15BbWU4MDU0NzA1MzAx.jpg"
        movie_info.rating.should == 8.2
        movie_info.votes.should == 110636
        movie_info.mpaa_rating.should == "Rated PG-13 for intense sequences of violence and action, some frightening images, thematic elements, a suggestive situation and language"
        movie_info.tagline.should == "Every revolution begins with a spark.  »"
        movie_info.year.should == 2013
        movie_info.release_date.should == "22 November 2013 (USA)"
      end
    end

    it "allows you to update attributes" do
      movie_info.title =  "Rails 4 Games: Turbolinks Reloaded!"
      movie_info.title.should ==  "Rails 4 Games: Turbolinks Reloaded!"
    end
  end

  describe "Adding multiple movies to data store" do
    before :each do 
      movie_DS = MovieDB::Movie.instance_eval{create_movie_info("2024544")}
      movie_DS = MovieDB::Movie.instance_eval{create_movie_info("1800241")}
    end

    it "Should return names of all titles" do
       MovieDB::Movie.instance_eval{filter_movie_attr("title")}.should == ["12 Years a Slave", "American Hustle"] 
    end

    it "Should return names of all directors" do
       MovieDB::Movie.instance_eval{filter_movie_attr("director")}.should == ["Steve McQueen", "David O. Russell"]
    end

    it "Should return names of all writers" do
       MovieDB::Movie.instance_eval{filter_movie_attr("writer")}.should == ["John Ridley, Solomon Northup", "Eric Singer, David O. Russell"]
    end
  end
end
