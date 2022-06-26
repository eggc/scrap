# frozen_string_literal: true

require 'scrap/version'
require 'scrap/fetcher'
require 'scrap/response'
require 'scrap/html'
require 'scrap/image'

# Scrap provides the ability to retrieve arbitrary elements of a website.
class Scrap
  def initialize(host)
    @fetcher = Scrap::Fetcher.new(host)
  end

  def get(path)
    response = Scrap::Response.new(@fetcher.fetch(path))

    case response.content_type
    when :html
      Scrap::HTML.new(response.body)
    when :image
      Scrap::Image.new(response.body)
    else
      message = "#{self.class.name} #{__method__} cannot receive a content-type #{response.content_type}"
      raise ArgumentError.new(message)
    end
  end
end
