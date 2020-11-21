require 'faraday'
require 'faraday_middleware'
require "scrap/cache"

class Scrap::Request
  class << self
    attr_accessor :verbose

    def call(url, cookie = nil)
      if verbose
        puts "request #{url} #{cookie}"
      end

      new(url, cookie).cache_or_request.body
    end
  end

  def initialize(url, cookie)
    @url = url
    @cookie = cookie
    @connection = build_connection(url)
  end

  def cache_or_request
    cache_key = [@url, @cookie].join
    cache = Scrap::Cache.get(cache_key)
    cache || Scrap::Cache.set(cache_key, request)
  end

  private

  def build_connection(url)
    Faraday.new(url: url) do |faraday|
      faraday.use(FaradayMiddleware::FollowRedirects)
      faraday.adapter Faraday.default_adapter
    end
  end

  def request
    @connection.get do |request|
      request.headers['cookie'] = @cookie if @cookie
    end
  end
end
