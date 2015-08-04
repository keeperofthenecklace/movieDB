require 'cgi'
module MovieDB
  module Support
    module Print
      # Print out 3 document formats
      # to screen.
      def self.print_document(data, **options)
        docs = []
        puts Gyoku.xml($data) if options[:print] == 'xml'
        data.each do |d|
          d.each do |e|
            next if e.length <= 20
              docs << JSON.pretty_generate(eval(e)) if options[:print] == 'pretty_json'
              docs << JSON.generate(eval(e)) if options[:print] == 'json'
              docs << eval(e) if options[:print] == 'hash'
          end
        end

        docs
      end
    end
  end
end