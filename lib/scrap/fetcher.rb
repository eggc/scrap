# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'
require 'scrap/response'

module Scrap
  # Scrap::Fetcher fetch files from web sites
  class Fetcher
    class << self
      def call(url)
        new.fetch(url)
      end
    end

    def initialize(host = nil)
      @host = host
      @connection = build_connection(host)
    end

    def fetch(path)
      Scrap::Response.new(@connection.get(path))
    end

    # @return [String] cookie used in connection
    # @note Basically, there is no need to call this method because the cookie is managed by middleware
    def cookie
      @connection.head.env.request_headers['Cookie']
    end

    private

    def build_connection(host)
      base_url = URI::HTTPS.build(host: host)

      Faraday.new(base_url) do |faraday|
        faraday.use(FaradayMiddleware::FollowRedirects)
        faraday.use(Faraday::CookieJar)
        faraday.adapter(Faraday.default_adapter)
      end
    end
  end
end
