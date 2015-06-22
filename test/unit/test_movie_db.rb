require 'test/unit'
require "imdb"
require "redis"
require 'fileutils'

begin
  require 'MovieDB'
rescue MovieError
end

class TestMovieDB < Test::Unit::TestCase

  # This unit test writes an excel file to the reports directory
  # in your gem folder.
  #
  # So, this method removes and empty the reports folder of
  # all or andy pre-existing test files.
  def remove_test_files_from_reports_directory
    testxlsfiles = File.join("**", "reports", "*.xls")
    FileUtils.rm Dir.glob(testxlsfiles)
  end

  def test_movie_new
    m = MovieDB::Movie.new
    assert_instance_of MovieDB::Movie, m
    assert_equal "Method Missing 2: Rails Roars!", m.title
    assert_equal ["David Black", "Paola Perotta", "Obie Fernandez", "David Chelimsky"], m.cast_members
    assert_equal ["David Black => Developer", "Paola Perotta => Police Officer", "Obie Fernandez =>Hunter", "David Chelimsky =>Hostage"], m.cast_members_characters
    assert_equal ["nm3901234", "nm4901244", "nm5901235", "nm3601266"], m.cast_member_ids
    assert_equal "http://imdb.com/video/screenplay/vi581042457/", m.trailer_url
    assert_equal "Yukihiro 'Matz' Matsumoto", m.director
    assert_equal 'David Heinemeier Hansson', m.writers
    assert_equal ["Manhattan, New York, USA"], m.filming_locations
    assert_equal "Open Source Community Film Corporation", m.company
    assert_equal ["Bromantic", "Syfy"], m.genres
    assert_equal ["English", "German", "Italian"], m.languages
    assert_equal ["USA", "Germany", "Italy"], m.countries
    assert_equal 146, m.length
    assert_equal ["David Black, a ruby developer, tries to write his flagship ruby book 'The Well-Grounded Rubyist vol. 186' only to find out that Ruby 9.0.2 and Rails 16.0.3 release dates have been postponed"], m.plot
    assert_equal "http://ia.media-imdb.com/images/M/MV5BMTY@@.jpg", m.poster
    assert_equal 9.9, m.rating
    assert_equal 110636, m.votes
    assert_equal "Rated R for dynamic OOD language usage and private methods access (certificate 33087)", m.mpaa_rating
    assert_equal 'Only One MVC Will Rule Them All.', m.tagline
    assert_equal 2013, m.year
    assert_equal "11 October 2013 (USA)", m.release_date
    assert_equal 456790, m.revenue
  end

  def test_find_imdb_id
    assert_raise(ArgumentError) { MovieDB::Movie.find_imdb_id() }
    assert_equal("imdb_JurassicWorld_.xls", MovieDB::Movie.find_imdb_id('0369610'))

    remove_test_files_from_reports_directory
  end

  def test_get_imdb_movie_data
    imdb_ids = ['0369610', '2395427']
    wrong_ids = ['abcd', 'cdef']

    assert_equal(2, MovieDB::Movie.get_imdb_movie_data(imdb_ids).length)
    assert_nil(nil, MovieDB::Movie.get_imdb_movie_data(wrong_ids))

    m = MovieDB::Movie.get_imdb_movie_data(imdb_ids)
    assert_equal("Jurassic World", m[0].title)
    assert_equal("Avengers: Age of Ultron", m[1].title)
  end

  def test_get_tmdb_movie_data
    imdb_ids = ['0078748', '0120338']
    assert_equal(2, MovieDB::Movie.get_tmdb_movie_data(imdb_ids).length)

    m = MovieDB::Movie.get_tmdb_movie_data(imdb_ids)
    assert_equal(104931801, m[0]['revenue'])
    assert_equal(1845034188, m[1]['revenue'])
  end

  def test_store_movie_data_to_redis
    imdb_ids = ["0369610"]

    MovieDB::Movie.get_imdb_movie_data(imdb_ids)
    MovieDB::Movie.get_tmdb_movie_data(imdb_ids)

    m = MovieDB::Movie.cache_movie_data_to_redis(imdb_ids)
    assert_equal("Jurassic World", (m.hget "movie:0369610", "title"))
  end

  def test_write_imdb_data_to_xls
    imdb_ids = ['0369610', '2395427']

    MovieDB::Movie.get_imdb_movie_data(imdb_ids)
    MovieDB::Movie.get_tmdb_movie_data(imdb_ids)
    m = MovieDB::Movie.cache_movie_data_to_redis(imdb_ids)

    assert_equal("imdb_JurassicWorld_Avengers:AgeofUltron_.xls", MovieDB::Movie.export_movie_data(m, imdb_ids))

    remove_test_files_from_reports_directory
  end
end

