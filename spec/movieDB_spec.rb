require 'spec_helper'

describe MovieDB do
  # Delete test reports/files from the reports directory.
  def deleteFile
    testxlsfiles = File.join("**", "reports", "*.xls")
    FileUtils.rm Dir.glob(testxlsfiles)
  end

  describe "#new" do
    m = MovieDB::Movie.new

    it "creates an object with default attribute values" do
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

    it "returns the attributes for the movie" do
      m = MovieDB::Movie.get_imdb_movie_data(imdb_ids)

      expect(m[0].title).to eql("Jurassic World")
      expect(m[1].title).to eql("Avengers: Age of Ultron")
    end

    it "raises an error for wrong IMDB ids" do
      expect { MovieDB::Movie.get_imdb_movie_data(wrong_ids) }.to raise_error("Wrong IMDb id")
    end
  end

  describe "#get_tmdb_movie_data" do
    imdb_ids = ['0078748', '0120338']

    it "fetches revenue data" do
      m = MovieDB::Movie.get_tmdb_movie_data(imdb_ids)

      expect(m[0]['revenue']).to eql  104_931_801
      expect(m[1]['revenue']).to eql  1_845_034_188
    end
  end

  describe "#store_movie_data_to_redis" do
    imdb_id = ["0369610"]

    MovieDB::Movie.get_imdb_movie_data(imdb_id)
    MovieDB::Movie.get_tmdb_movie_data(imdb_id)
    m = MovieDB::Movie.cache_movie_data_to_redis(imdb_id)

    it "returns the title from redis" do
      expect(m.hget "movie:0369610", "title").to eql "Jurassic World"
    end
  end

  describe "#write_imdb_data_to_xls" do
    imdb_ids = ['0369610', '2395427']

    MovieDB::Movie.get_imdb_movie_data(imdb_ids)
    MovieDB::Movie.get_tmdb_movie_data(imdb_ids)
    m = MovieDB::Movie.cache_movie_data_to_redis(imdb_ids)

    it "performs computation and writes to a xls file" do
      expect(MovieDB::Movie.export_movie_data(m, imdb_ids)).to eql "imdb_JurassicWorld_Avengers:AgeofUltron_.xls"
      deleteFile
    end
  end
end
