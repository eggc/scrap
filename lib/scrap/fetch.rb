require "open-uri"
require "nokogiri"

module Scrap::Fetch
  def fetch(url, key)
    raw_html = open(url).read
    document = Nokogiri::HTML.parse(raw_html)
    document.css(key)
  end
end
