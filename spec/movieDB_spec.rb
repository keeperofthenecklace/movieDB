require 'spec_helper'

describe MovieDB do
  # Delete test reports/files from the reports directory.
  def deleteFile
    testxlsfiles = File.join("**", "reports", "*.xls")
    FileUtils.rm Dir.glob(testxlsfiles)
  end

  describe "#new" do
    m = MovieDB::Movie.new

    it "creates an object with default values" do
      expect(m.title).to eql "Method Missing 2: Rails Roars!"
      expect(m.cast_members).to eql (["David Black", "Paola Perotta", "Obie Fernandez", "David Chelimsky"])
      expect(m.cast_members_characters).to eql (["David Black => Developer", "Paola Perotta => Police Officer", "Obie Fernandez =>Hunter", "David Chelimsky =>Hostage"])
      expect(m.cast_member_ids).to eql (["nm3901234", "nm4901244", "nm5901235", "nm3601266"])
      expect(m.trailer_url).to eql ("http://imdb.com/video/screenplay/vi581042457/")
      expect(m.director).to eql ("Yukihiro 'Matz' Matsumoto")
      expect(m.writers).to eql ('David Heinemeier Hansson')
      expect(m.filming_locations).to eql(["Manhattan, New York, USA"])
      expect(m.company).to eql ("Open Source Community Film Corporation")
      expect(m.genres).to eql (["Bromantic", "Syfy"])
      expect(m.languages).to eql (["English", "German", "Italian"])
      expect(m.countries).to eql (["USA", "Germany", "Italy"])
      expect(m.length).to eq(146)
      expect(m.plot).to eql (["David Black, a ruby developer, tries to write his flagship ruby book 'The Well-Grounded Rubyist vol. 186' only to find out that Ruby 9.0.2 and Rails 16.0.3 release dates have been postponed"])
      expect(m.poster).to eql ("http://ia.media-imdb.com/images/M/MV5BMTY@@.jpg")
      expect(m.rating).to eql (9.9)
      expect(m.votes).to eql (110636)
      expect(m.mpaa_rating).to eql ("Rated R for dynamic OOD language usage and private methods access (certificate 33087)")
      expect(m.tagline).to eq ('Only One MVC Will Rule Them All.')
      expect(m.year).to eql (2013)
      expect(m.release_date).to eql ("11 October 2013 (USA)")
      expect(m.revenue).to eql (456790)
    end
  end

  describe "#find_imdb_id" do
    it "raises an error if thers no ids" do
      expect { MovieDB::Movie.find_imdb_id() }.to raise_error
    end

    it "returns an IMDb movie if id is valid" do
      expect(MovieDB::Movie.find_imdb_id('0369610')).to eql ("imdb_JurassicWorld_.xls")
      deleteFile
    end
  end

  describe "#get_imdb_movie_data" do
    imdb_ids = ['0369610', '2395427']
    wrong_ids = ['abcd', 'cdef']

    it "return length of movies" do
      expect(MovieDB::Movie.get_imdb_movie_data(imdb_ids).length).to eql 2
    end

    it "raise an error for wrong IMDB ids" do
      expect { MovieDB::Movie.get_imdb_movie_data(wrong_ids) }.to raise_error("Wrong IMDb id")
    end
  end















end
