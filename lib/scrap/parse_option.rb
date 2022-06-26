# frozen_string_literal: true

require 'optparse'

class Scrap
  # ParseOption interprets the program arguments
  module ParseOption
    def parse_options
      params = default_options
      opt = OptionParser.new
      opt.on('--url=VAL') { |v| v }
      opt.on('--selector=VAL') { |v| v }
      opt.on('--attribute=VAL') { |v| v }
      opt.parse!(ARGV, into: params)
      params
    end

    def default_options
      {
        url: 'https://google.co.jp',
        selector: 'a'
      }
    end
  end
end
