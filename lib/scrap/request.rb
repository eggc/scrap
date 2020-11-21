# frozen_string_literal: true

require 'singleton'
require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'

module Scrap
  # Scrap::Request has a cookie and works like some kind of web browser
  class Request
    include Singleton

    class << self
      def call(url)
        instance.request(url)
      end

      # @return [String] cookie used in connection
      # @note Basically, there is no need to call this method because the cookie is managed by middleware
      def cookie(url: nil, host: nil)
        instance.connection.host = host || URI.parse(url).host
        instance.connection.head.env.request_headers['Cookie']
      end
    end

    def connection
      @connection ||= build_connection
    end

    def request(url)
      connection.get(url)
    end

    def build_connection
      Faraday.new do |faraday|
        faraday.use(FaradayMiddleware::FollowRedirects)
        faraday.use(Faraday::CookieJar)
        faraday.adapter(Faraday.default_adapter)
      end
    end
  end
end
