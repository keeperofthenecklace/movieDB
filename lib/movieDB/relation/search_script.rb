# Word and punctuation frequency.
#
# Steps:
#
#   1. Read the text file into a string
#   2. Split the text into an array of words
#   3. Count the number of times each word occurs, storing it in a hash
#   4. Display the word frequency list
# encoding: utf-8
require 'set'
module MovieDB
  module Relation
    class MovieScript

      attr_reader :name, :characters, :vectors

      # counts all the alpha characters and stops on a sentence.
      # encoding: utf-8

      def initialize(script_io, title)
        @title = title
        @vectors, @characters = Tokenizer.tokenize(script_io)
      end

      def self.word_frequency(file: )
        h = Hash.new
        f = File.open(file, 'r')

        f.each_line { |line|
          words = line.split
          words.each { |w|
            w = w.downcase
           if  h.has_key?(w)
             h[w] = h[w] + 1
           else
             h[w] = 1
           end
          }
        }

        # sort the hash by value, and then print it in sorted order.
        h.sort { |a, b| a[1] <=> b[1] }.each { |elem|
          puts "\"#{elem[0]}\" has #{elem[1] } occurences"
        }
      end
    end
  end
end

a =   MovieDB::Relation::MovieScript.word_frequency(file: '/Users/albertmckeever/Downloads/american_hustle.txt')

p Hash[a]