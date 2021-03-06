# frozen_string_literal: true

require 'forwardable'

module Scrap
  # Scrap::Response is wrapper of Faraday::Response
  class Response
    extend Forwardable

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

    def_delegators :@faraday_response, :body, :status
  end
end
