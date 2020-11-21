# frozen_string_literal: true

require 'singleton'
require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'
require 'scrap/response'

module Scrap
  # Scrap::Fetcher fetch files from web sites
  class Fetcher
    include Singleton

    class << self
      def call(url)
        instance.fetch(url)
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

    def fetch(url)
      uri = URI.parse(url)
      uri.scheme ||= 'https'

      if uri.host
        connection.host = uri.host
      else
        uri.host = connection.host
      end

      Scrap::Response.new(connection.get(uri.to_s))
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
