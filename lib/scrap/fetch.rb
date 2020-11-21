require "nokogiri"
require 'faraday'
require "scrap/cache"

class Scrap::Fetch
  class << self
    attr_accessor :verbose

    def call(url:, selector:, attribute: nil, cookie: nil)
      if verbose
        puts "fetch #{url} #{selector} #{attribute}"
      end

      raw_html = cache_or_request(url, cookie).body
      document = Nokogiri::HTML.parse(raw_html)
      elements = document.css(selector)
      attribute ? pluck(elements, attribute) : elements
    end

    private

    def cache_or_request(url, cookie)
      cache_key = [url, cookie].join
      cache = Scrap::Cache.get(cache_key)
      cache || Scrap::Cache.set(cache_key, request(url, cookie))
    end

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
      end
    end
  end
end
