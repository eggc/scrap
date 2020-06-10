require "scrap/version"
require "scrap/fetch"

module Scrap
  class Error < StandardError; end

  extend Fetch

  def self.main(url)
    puts fetch(url, "a")
  end
end
