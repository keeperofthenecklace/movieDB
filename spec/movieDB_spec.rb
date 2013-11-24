require 'spec_helper'

describe MovieDB do
  let(:defaultMovie){ MovieDB::Movie.new() }

  describe "Initialize" do
    it "should create a default list of movie attributes" do
      defaultMovie.title.should ==  "Method Missing"
      defaultMovie.cast.should ==  ['David Black', "Paola Perotta", "Obie Fernandez", "David Chelimsky"]
      defaultMovie.director.should ==  "Yukihiro 'Matz' Matsumoto"
      defaultMovie.released_date.should ==  "2005-12-13"
      defaultMovie.film_release.should ==  ['theatrical', 'video', 'television', 'internet', 'print']
      defaultMovie.writer.should ==  'David Heinemeier Hansson'
      defaultMovie.genre.should ==  ["Bromantic", "Syfy"]
      defaultMovie.academy_award_nomination.should ==  4
      defaultMovie.academy_award_wins.should ==  3
      defaultMovie.golden_globe_nominations.should ==  4
      defaultMovie.golden_globe_wins.should ==  2
      defaultMovie.bafta_nomination.should ==  3
      defaultMovie.bafta_wins.should ==  1
      defaultMovie.worldwide_gross.should ==  "$9750 Million"
    end

    it "should allow you to update title" do
      defaultMovie.title =  "Rails 4: Turbolinks Reloaded!"
      defaultMovie.title.should ==  "Rails 4: Turbolinks Reloaded!"
    end
  end

  describe "Adding movies to data store" do
    before :each do 
      movie_DS = MovieDB::Movie.instance_eval{create_movie_info('Thor', %w(Chris_Hemsworth Natalie_Portman Tom_Hiddleston), 'Jon Turteltaub', 
                           '2013-10-30', ['theatrical', 'print'], ["Christopher_Yost", "Christopher Markus"], ['Action', 'Adventure', 'Fantasy'], "", 
                            "",  "", "", "", "", "", '$86.1 Million')}
      movie_DS = MovieDB::Movie.instance_eval{create_movie_info('Last Vegas',  %w(Morgan Freeman', 'Robert De Niro', 'Michael Douglas', 'Kevin Kline', 'Mary Steenburgen'), 'Alan Taylor', 
                           '2013-10-30', ['theatrical', 'print'], ["Dan Fogelman"], ['Comedy'], "", 
                            "",  "", "", "", "", "", '$11.2 Million')}

    end

    it "Should return names of all titles" do
       MovieDB::Movie.instance_eval{filter_movie_attr("title")}.should == ["Thor", "Last Vegas"]
    end

    it "Should return names of all directors" do
       MovieDB::Movie.instance_eval{filter_movie_attr("director")}.should == ["Jon Turteltaub", "Alan Taylor"]
    end
  end

  describe "Raise an Error" do
      it "should raise an error if title already exists" do
       expect { movie_DS }.to raise_error
    end
  end

  context "#capture" do
    let!(:newCap){ MovieDB::Movie.new()}

    it "should accept new synopsis argument" do
      newCap.capture( synopsis:  "Last Vegas - Four geriatric friends vow to set Las Vegas Ablaze.").should === {:synopsis=>"Last Vegas - Four geriatric friends vow to set Las Vegas Ablaze."} 

    end
  end 
end
