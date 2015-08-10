require 'redis'
require 'json'
require 'imdb'
require 'MovieDB'
require 'spec_helper'

describe MovieDB do

  let(:m) { MovieDB::Movie.new }

  describe ".write_data" do
    context 'when fetch movie data' do
      it 'write data to redis' do
        # pending
      end
    end
  end

  describe ".get_data" do
    context 'when getting movie data' do
      it 'fetch data from redis with the require method' do
        # pending
      end

      it 'raise error if method does not exists' do
        # pending
      end
    end
  end
end

