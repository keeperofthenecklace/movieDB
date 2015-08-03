require 'gyoku'

module MovieDB
  module Relation
    module PrintMethods
      def json
        MovieDB::Support::Print.print_document($data, print: 'json')
      end

      def pretty_json
        MovieDB::Support::Print.print_document($data, print: 'pretty_json')
      end

      def xml
        MovieDB::Support::Print.print_document($data, print: 'xml')
      end
    end
  end
end