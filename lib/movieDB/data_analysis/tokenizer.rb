module MovieDB
  module DataAnalysis
    module Tokenizer
      extend self

      PUNCTUATION = %w[~ @ # $ % ^ & * ( ) _ + ' [ ] “ ” ‘ ’ — < > » « › ‹ – „ /]
      SPACES = [" ", "\u00A0", "\n"]
      STOP_CHARACTERS = ['.', '?', '!']
      VOWELS = %w[a e i o u]
      CONSONANT = %w[B C D F G H J K L M N P Q R S T V X Z W]
      CONJUNCTION = %w[for and nor but or yet so]
      NOUN = []
      VERB = []
      ADJECTIVE = []
      ADVERB = []
      PRONOUN = %w[there you i that he she they me them it who whom where we us him her ours our this some none which each other]
      PARAGRAPH = []

      # Code taken form 'thoughtful machine learning'
      def tokenize(blob)
        unless blob.respond_to?(:each_char)
          raise 'Please implement each_char on blob'
        end

        vectors = []
        dist = Hash.new(0)

        characters = Set.new
        blob
      end
    end
  end
end

