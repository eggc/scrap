require "scrap/version"
require "open-uri"
require "nokogiri"

module Scrap
  class Error < StandardError; end

  def self.main(url)
    raw_html = open(url).read
    puts Nokogiri::HTML.parse(raw_html)
  end
end
