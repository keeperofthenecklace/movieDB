require 'cgi'
module MovieDB
  module Support
    module Print
      # Prints out document in 3 formats.
      #
      #  TODO: Add XML format.
      def self.print_document(data, **options)
        return Gyoku.xml($data) if options[:print] == 'xml'

        data.each do |d|
          d.each do |e|
            next if e.length <= 20
            return JSON.pretty_generate(eval(e)) if options[:print] == 'pretty_json'
            return JSON.generate(eval(e)) if options[:print] == 'json'
            return eval(e) if options[:print] == 'hash'
          end
        end
      end
    end
  end
end