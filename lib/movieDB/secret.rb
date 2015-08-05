require 'MovieDB'

module MovieDB
  module Secret
    module Lock
      def self.key
        @key = "a7bd30a701e25551268b048c9c640360"
      end
    end
  end
end
