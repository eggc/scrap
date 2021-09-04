# frozen_string_literal: true

require 'scrap/version'
require 'scrap/fetcher'
require 'scrap/filter'

# Scrap provides the ability to retrieve arbitrary elements of a website.
module Scrap
  def self.fetch(url:, selector: nil, attribute: nil)
    response = Scrap::Fetcher.call(url)

    if response.html?
      Scrap::Filter.call(
        html: response.body,
        selector: selector,
        attribute: attribute
      )
    else
      response.body
    end
  end
end
