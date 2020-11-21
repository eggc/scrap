# frozen_string_literal: true

require 'nokogiri'
require 'scrap/request'

module Scrap
  # Scrap::Filter extracts the specified elements from a string of html
  class Filter
    class << self
      attr_accessor :verbose

      def call(url:, selector:, attribute: nil)
        puts "filter #{url} #{selector} #{attribute}" if verbose

        raw_html = Scrap::Request.call(url)
        document = Nokogiri::HTML.parse(raw_html)
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
