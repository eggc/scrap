# frozen_string_literal: true

require 'scrap/version'
require 'scrap/fetcher'
require 'scrap/response'
require 'scrap/html'

# Scrap provides the ability to retrieve arbitrary elements of a website.
class Scrap
  def initialize(host)
    @fetcher = Scrap::Fetcher.new(host)
  end

  def get(url)
    Scrap::Response.new(@fetcher.fetch(url))
  end
end
