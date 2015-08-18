require 'spec_helper'
require 'json'

describe MovieDB do
  m =  MovieDB::Movie.new

  describe "#store_data" do

  end

  context "#fetch" do
    movie = m.fetch("0369610")

    it 'should get the movie and return title' do
      expect(movie[0]['title']).to eq("Jurassic World")
    end

    it 'should get the movie and return director' do
      expect(JSON.parse(movie[0]['director'])).to eq(["Colin Trevorrow"])
    end

    it 'should get the movie and return revenue' do
      expect(movie[0]['revenue']).to eq('1513528810')
    end

    it 'should get the movie and store to redis for 1800 seconds' do
      expect(m.ttl("0369610")).to be_within(1700).of(1800)
    end

    it 'should allow user to change expiration time.' do
      m.fetch('0478970', expire: 3000)

      expect(m.ttl('0478970')).to be_within(2800).of(3000)
    end
  end

  context "#hgetall" do
    it 'should get all the fields and values in a hash of the movie' do
      expect(m.hgetall("0369610").count).to eq(45)
    end
  end

  context "#hkeys" do
    it 'should get all the fields in a hash of the movie' do
      expect(m.hkeys("0369610")).to eq(["production_companies", "belongs_to_collection", "plot_synopsis", "company", "title", "filming_locations", "cast_characters", "trailer_url", "cast_members", "votes", "adult", "also_known_as", "director", "plot_summary", "countries", "backdrop_path", "poster", "budget", "status", "overview", "rating", "cast_members_characters", "id", "homepage", "original_language", "original_title", "revenue", "length", "year", "tagline", "mpaa_rating", "poster_path", "production_countries", "popularity", "release_date", "genres", "writers", "video", "spoken_languages", "languages", "vote_count", "vote_average", "plot", "imdb_id", "runtime"])
    end
  end

  context "#hvals" do
    it 'should get all the values in a hash of the movie' do
      # expect(m.hvals("0369610")).to eq({\"name\"=>\"Universal Studios\", \"id\"=>13}...)
    end
  end

  describe "#all_ids" do
    it 'should get all IMDb ids stored in redis' do
      expect(m.all_ids).to eq(["0478970", "0369610"])
    end
  end

  describe "#delete_all" do
    it 'should delete all movies stored in redis' do
      m.fetch("0478970", "0369610")
      expect(m.all_ids.count).to eq(2)

      m.delete_all
      expect(m.all_ids.count).to eq(0)
    end
  end

end