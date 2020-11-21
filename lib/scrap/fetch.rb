require "nokogiri"
require "scrap/request"

class Scrap::Fetch
  class << self
    attr_accessor :verbose

    def call(url:, selector:, attribute: nil)
      if verbose
        puts "fetch #{url} #{selector} #{attribute}"
      end

      raw_html = Scrap::Request.call(url)
      document = Nokogiri::HTML.parse(raw_html)
      elements = document.css(selector)
      attribute ? pluck(elements, attribute) : elements
    end

    private

    def pluck(elements, attribute)
      if attribute
        elements.map do |element|
          element.get_attribute(attribute)
        end
      end
    end
  end
end
