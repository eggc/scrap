# frozen_string_literal: true

require 'scrap/version'
require 'scrap/fetcher'

# Scrap provides the ability to retrieve arbitrary elements of a website.
module Scrap
  def self.get(url)
    Scrap::Fetcher.call(url)
  end

  def self.fetch(url:, selector: nil, attribute: nil)
    response = get(url)

    if response.html?
      response.query(selector, attribute)
    else
      response.body
    end
  end
end
