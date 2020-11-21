require "nokogiri"
require 'faraday'
require "scrap/cache"

class Scrap::Fetch
  class << self
    def call(url:, selector:, attribute: nil, cookie: nil)
      puts "fetch #{url} #{selector} #{attribute}"

      raw_html = request(url, cookie).body
      document = Nokogiri::HTML.parse(raw_html)
      elements = document.css(selector)
      pluck(elements, attribute)
    end

    private

    def request(url, cookie)
      Faraday.get(url) do |request|
        request.headers['cookie'] = cookie if cookie
      end
    end

    def pluck(elements, attribute)
      if attribute
        elements.map do |element|
          element.get_attribute(attribute)
        end
      else
        elements
      end
    end
  end
end
