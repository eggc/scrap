require "scrap/version"
require "scrap/parse_option"
require "scrap/fetch"

module Scrap
  class Error < StandardError; end

  extend ParseOption

  def self.main
    fetch(**parse_options)
  end

  def self.fetch(**args)
    Scrap::Fetch.call(args)
  end
end
