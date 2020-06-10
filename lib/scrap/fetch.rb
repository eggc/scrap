require "open-uri"
require "nokogiri"

module Scrap::Fetch
  def fetch(url, key, attribute = nil)
    raw_html = open(url).read
    document = Nokogiri::HTML.parse(raw_html)

    if attribute
      document.css(key).map do |element|
        element.get_attribute(attribute)
      end
    else
      document.css(key)
    end
  end
end
