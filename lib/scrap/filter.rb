# frozen_string_literal: true

require 'nokogiri'

module Scrap
  # Scrap::Filter extracts the specified elements from a string of html
  class Filter
    class << self
      def call(html:, selector: nil, attribute: nil)
        document = Nokogiri::HTML.parse(html)
        document = document.css(selector) if selector
        attribute ? pluck(document, attribute) : document.map(&:inner_text)
      end

      private

      def pluck(elements, attribute)
        elements.map do |element|
          element.get_attribute(attribute)
        end
      end
    end
  end
end
