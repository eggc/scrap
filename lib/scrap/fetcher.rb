# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'
require 'scrap/cookie'

class Scrap
  # Scrap::Fetcher fetch files from web sites
  class Fetcher
    class << self
      def call(url)
        new.fetch(url)
      end
    end

    def initialize(host = nil, cookie_hash = {})
      @host = host
      @cookie = Scrap::Cookie.new(cookie_hash, host)
      @connection = build_connection(host, @cookie)
    end

    def fetch(path)
      @connection.get(path)
    end

    def post(path, **body)
      @connection.post(path) do |request|
        request.body = body
      end
    end

    private

    def build_connection(host, cookie)
      base_url = URI::HTTPS.build(host: host)

      Faraday.new(base_url) do |faraday|
        faraday.use(FaradayMiddleware::FollowRedirects)
        faraday.use(Faraday::CookieJar, jar: cookie.jar)
        faraday.adapter(Faraday.default_adapter)
      end
    end
  end
end
