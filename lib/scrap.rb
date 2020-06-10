require "scrap/version"
require "open-uri"

module Scrap
  class Error < StandardError; end

  def self.main(url)
    raw_html = open(url).read
    puts(raw_html)
  end
end
