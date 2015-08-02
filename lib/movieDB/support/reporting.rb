module MovieDB
  module Support
    module Reporting

      def self.warn(message = nil)
        return if silenced

        puts message
      end

      def self.silenced
        # code goes here.
        # yield
      ensure
        # code goes here.
      end
    end
  end
end