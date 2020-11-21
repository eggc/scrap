require "nokogiri"
require 'faraday'

module Scrap::Fetch
  def fetch(url:, selector:, attribute: nil, cookie: nil)
    puts "fetch #{url} #{selector} #{attribute}"

    response = Faraday.get(url) do |request|
      request.headers['cookie'] = cookie if cookie
    end

    raw_html = response.body
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
