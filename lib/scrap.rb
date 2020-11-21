# frozen_string_literal: true

require 'scrap/version'
require 'scrap/parse_option'
require 'scrap/filter'

# Scrap provides the ability to retrieve arbitrary elements of a website.
module Scrap
  class Error < StandardError; end

  extend ParseOption

  def self.main
    fetch(**parse_options)
  end

  def self.fetch(**args)
    Scrap::Filter.call(args)
  end
end
