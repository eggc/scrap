# frozen_string_literal: true

require 'forwardable'
require 'json'

class Scrap
  # Scrap::Response is wrapper of Faraday::Response
  class Response
    extend Forwardable

    def_delegators :@faraday_response, :body, :status

    def initialize(faraday_response)
      @faraday_response = faraday_response
    end

    def content_type
      case @faraday_response.headers['content-type']
      when %r{text/html} then :html
      when /^image|jpe?g|png/ then :image
      when 'application/json' then :json
      end
    end

    def html?
      content_type == :html
    end

    def image?
      content_type == :image
    end

    def json?
      content_type == :json
    end

    def to_h
      JSON.parse(body)
    end

    def url
      @faraday_response.env.url
    end

    def file_name
      url.to_s.split('/').last
    end
  end
end
