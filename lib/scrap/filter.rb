# frozen_string_literal: true

require 'nokogiri'

module Scrap
  # Scrap::Filter extracts the specified elements from a string of html
  class Filter
    class << self
      attr_accessor :verbose

      def call(html:, selector:, attribute: nil)
        puts "filter by #{selector} #{attribute}" if verbose

        document = Nokogiri::HTML.parse(html)
        elements = document.css(selector)
        attribute ? pluck(elements, attribute) : elements
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
