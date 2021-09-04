# frozen_string_literal: true

require 'forwardable'
require 'scrap/filter'

module Scrap
  # Scrap::Response is wrapper of Faraday::Response
  class Response
    extend Forwardable

    def_delegators :@faraday_response, :body, :status

    def initialize(faraday_response)
      @faraday_response = faraday_response
    end

    def content_type
      @faraday_response.headers['content-type']
    end

    def html?
      content_type.start_with?('text/html')
    end

    def image?
      content_type.start_with?('image')
    end

    def save_to(path)
      File.open(path, 'wb') do |file|
        file.write(@faraday_response.body)
      end
    end

    def query(selector, attribute)
      Scrap::Filter.call(
        html: @faraday_response.body,
        selector: selector,
        attribute: attribute
      )
    end
  end
end
