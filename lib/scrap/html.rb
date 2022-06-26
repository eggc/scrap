# frozen_string_literal: true

require 'nokogiri'

class Scrap
  class HTML
    def initialize(html_string)
      @html = Nokogiri::HTML.parse(html_string)
    end

    def title
      query(selector: 'title', attribute: :inner_text).first
    end

    def image_urls
      query(selector: 'img', attribute: 'src').compact
    end

    def query(selector:, attribute:)
      elements = @html
      elements = @html.css(selector) if selector

      if attribute == :inner_text
        elements.map(&:inner_text)
      else
        elements.map { |element| element.get_attribute(attribute) }
      end
    end
  end
end
