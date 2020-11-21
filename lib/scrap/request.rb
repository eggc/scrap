require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'
require "scrap/cache"

class Scrap::Request
  class << self
    attr_accessor :verbose

    def call(url)
      if verbose
        puts "request #{url}"
      end

      new(url).cache_or_request.body
    end
  end

  def initialize(url)
    @url = url
    @connection = build_connection(url)
  end

  def cache_or_request
    cache = Scrap::Cache.get(@url)
    cache || Scrap::Cache.set(@url, request)
  end

  private

  def build_connection(url)
    Faraday.new(url: url) do |faraday|
      faraday.use(FaradayMiddleware::FollowRedirects)
      faraday.use(Faraday::CookieJar)
      faraday.adapter(Faraday.default_adapter)
    end
  end

  def request
    @connection.get
  end
end
