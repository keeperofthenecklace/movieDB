require 'spec_helper'
require 'MovieDB'

describe MovieDB do
  m =  MovieDB::Movie.new

  context '#graph' do
    it 'should plot a bar graph' do
      m.mean only: [:length, :vote_average]
      expect(m.graph(type: :bar, name: 'vote_length')).to eq(2200)
    end
  end
end

