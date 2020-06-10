require "scrap/version"
require "scrap/parse_option"
require "scrap/fetch"

module Scrap
  class Error < StandardError; end

  extend Fetch
  extend ParseOption

  def self.main
    fetch(**parse_options)
  end
end
