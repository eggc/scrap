# frozen_string_literal: true

require 'faraday'
require 'faraday-cookie_jar'
require 'faraday/follow_redirects'

class Scrap
  # Scrap::Browser browse files from web sites
  class Browser
    class << self
      def call(url)
        new.get(url)
      end
    end

    def initialize(host = nil, cookie_hash = {})
      @host = host
      @cookie = Scrap::Cookie.new(cookie_hash, host)
      @connection = build_connection(host, @cookie)
    end

    def get(path)
      @connection.get(path)
    end

    def post(path, **body)
      @connection.post(path) do |request|
        request.body = body
      end
    end

    private

    def build_connection(host, cookie)
      base_url = URI::HTTPS.build(host:)

      Faraday.new(base_url) do |faraday|
        faraday.response :follow_redirects

        faraday.use(Faraday::CookieJar, jar: cookie.jar)
        faraday.adapter(Faraday.default_adapter)
      end
    end
  end
end
