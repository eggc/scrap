require 'faraday'
require "scrap/cache"

class Scrap::Request
  class << self
    attr_accessor :verbose

    def call(url, cookie = nil)
      if verbose
        puts "request #{url} #{cookie}"
      end

      cache_or_request(url, cookie).body
    end

    private

    def cache_or_request(url, cookie)
      cache_key = [url, cookie].join
      cache = Scrap::Cache.get(cache_key)
      cache || Scrap::Cache.set(cache_key, request(url, cookie))
    end

    def request(url, cookie)
      Faraday.get(url) do |request|
        request.headers['cookie'] = cookie if cookie
      end
    end
  end
end
