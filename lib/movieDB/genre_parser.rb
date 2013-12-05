# encoding: UTF-8

module MovieDB
  class GenreParser

    def initialize
      begin 
        open_genre_file = File.open("#{File.dirname(__FILE__)}/genres/en.txt").readlines.map(&:chomp)
      rescue
       Errno::ENONENT 
      end
    end
  end
end

