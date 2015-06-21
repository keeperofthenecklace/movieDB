require 'test/unit'
# require 'MovieDB'
load "/Users/albertmckeever/Sites/movieDB/lib/movieDB.rb"

class TestMovieDB < Test::Unit::TestCase
  # MovieDB::Movie.new

  def test_getdata
    assert_equal("imdb_JurassicWorld_.xls", MovieDB::Movie.get_data('0369610'))
  end
end

