# frozen_string_literal: true

require 'nokogiri'
require 'scrap/request'

module Scrap
  class Fetch
    class << self
      attr_accessor :verbose

      def call(url:, selector:, attribute: nil)
        puts "fetch #{url} #{selector} #{attribute}" if verbose

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
end
