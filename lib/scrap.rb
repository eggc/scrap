require "scrap/version"
require "open-uri"
require "nokogiri"

module Scrap
  class Error < StandardError; end

  def self.main(url)
    puts fetch(url, "a")
  end

  def self.fetch(url, key)
    raw_html = open(url).read
    document = Nokogiri::HTML.parse(raw_html)
    document.css(key)
  end
end
