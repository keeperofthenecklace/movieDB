require 'spec_helper'
require 'MovieDB/data_process'
require 'MovieDB/data_analysis'

describe MovieDB::DataAnalysis do
  describe "basic_statistics" do
   file_name = MovieDB::Movie.get_data('0369610', "3079380")

    let(:basic_stats) { MovieDB::DataProcess.send(:basic_statistic, 'imdb_JurassicWorld_Spy_.xls') }

    it "performs calculation on existing data and writes to file." do

      expect(basic_stats).to eq "Statistic_imdb_JurassicWorld_Spy.xls"
    end
  end
end
