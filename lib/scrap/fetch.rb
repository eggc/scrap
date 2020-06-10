require "open-uri"
require "nokogiri"

module Scrap::Fetch
  def fetch(url:, selector:, attribute: nil)
    puts "fetch #{url} #{selector} #{attribute}"
    raw_html = URI.open(url).read
    document = Nokogiri::HTML.parse(raw_html)

    if attribute
      document.css(selector).map do |element|
        element.get_attribute(attribute)
      end
    else
      document.css(selector)
    end
  end
end
