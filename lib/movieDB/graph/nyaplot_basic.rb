require 'nyaplot'

module MovieDB
  module Graph
    module NyaplotBasic
      include Nyaplot

      def graph(options = {})
        case options[:type]
          when :bar
            plot = Nyaplot::Plot.new
            plot.add(:bar, $data_key.keys, $collect_vals[:vals].collect { |x| x })
            plot.x_label("Title")
            plot.y_label($collect_vals[:method])
            plot.export_html("#{options[:name]}.html")
          else
        end
      end
    end
  end
end