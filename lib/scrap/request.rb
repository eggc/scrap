require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'

class Scrap::Request
  class << self
    attr_accessor :verbose

    def call(url)
      if verbose
        puts "request #{url}"
      end

      new(url).request.body
    end
  end

  def initialize(url)
    @url = url
    @connection = build_connection(url)
  end

  # 現在のコネクションで使われるクッキーを返す
  # 自動でクッキーは管理されているので、内容確認以外の目的でこのメソッドを呼ぶ必要はない
  def cookie
    @connection.head.env.request_headers["Cookie"]
  end

  def request
    @connection.get
  end

  private

  def build_connection(url)
    Faraday.new(url: url) do |faraday|
      faraday.use(FaradayMiddleware::FollowRedirects)
      faraday.use(Faraday::CookieJar)
      faraday.adapter(Faraday.default_adapter)
    end
  end
end
