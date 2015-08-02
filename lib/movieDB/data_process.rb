require 'MovieDB/data_analysis'

module MovieDB
  module DataProcess
    STATISTIC = %w(median mean average mode)

    def statistic(*args) #:nodoc:
      # attr_accessor (args)

      @stats = args

      raise NameError, "#{@invalid_statistics} is not supported." unless statistics_exists?
      calculate_stats
      write_results_to_json
    end

    def statistics_exists?
      @invalid_statistics = []

      @stats.each do |s|
        (STATISTIC.include? s) ? true : @invalid_statistics << "#{s}"
      end
    end
  end

end
