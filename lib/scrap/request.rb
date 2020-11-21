require 'singleton'
require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'

class Scrap::Request
  include Singleton

  class << self
    attr_accessor :verbose

    def call(url)
      if verbose
        puts "request #{url}"
      end

      instance.request(url).body
    end

    # 現在のコネクションで使われるクッキーを返す
    # 自動でクッキーは管理されているので基本的にこのメソッドを呼ぶ必要はない
    def cookie(url: nil, host: nil)
      instance.connection.host = host || URI.parse(url).host
      instance.connection.head.env.request_headers["Cookie"]
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
