require "scrap/version"

module Scrap
  class Error < StandardError; end

  def self.main(options)
    puts "hello #{options}"
  end
end
