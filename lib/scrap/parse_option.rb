require 'optparse'

module Scrap::ParseOption
  def parse_options
    opts = ARGV.getopts("", "url:")
    opts["url"] ||= "https://google.co.jp"
    opts
  end
end
