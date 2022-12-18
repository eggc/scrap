# frozen_string_literal: true

require 'nokogiri'

class Scrap
  class HTML
    def initialize(html_string)
      @html = Nokogiri::HTML.parse(html_string)
    end

    def title
      query(selector: 'title', attributes: :inner_text).first[:inner_text]
    end

    def image_urls
      query(selector: 'img', attributes: 'src').map { _1['src'] }.compact
    end

    def query(selector:, attributes:)
      @html.css(selector).map do |element|
        Array(attributes).each_with_object({}) do |attribute, hash|
          hash[attribute] =
            if attribute == :inner_text
              element.inner_text
            else
              element.get_attribute(attribute)
            end
        end
      end
    end
  end
end
