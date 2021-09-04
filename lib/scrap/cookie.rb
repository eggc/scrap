# frozen_string_literal: true

module Scrap
  # Scrap::Cookie setup HTTP::CookieJar from any hash
  class Cookie
    attr_reader :jar

    def initialize(hash, domain)
      @jar = HTTP::CookieJar.new

      build_cookies(hash, domain).each do |cookie|
        @jar.add(cookie)
      end
    end

    private

    def build_cookies(hash, domain)
      hash.map do |key, value|
        HTTP::Cookie.new(
          name: key,
          value: value,
          domain: domain,
          for_domain: true,
          path: '/',
          max_age: 7 * 86_400
        )
      end
    end
  end
end
