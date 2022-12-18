# frozen_string_literal: true

require 'scrap/version'
require 'scrap/browser'
require 'scrap/response'
require 'scrap/html'
require 'scrap/image'

# Scrap provides the ability to retrieve arbitrary elements of a website.
class Scrap
  def initialize(host)
    @browser = Scrap::Browser.new(host)
  end

  def get(path)
    response = Scrap::Response.new(@browser.get(path))

    case response.content_type
    when :html
      Scrap::HTML.new(response.body)
    when :image
      Scrap::Image.new(response.file_name, response.body)
    else
      message = "#{self.class.name} #{__method__} cannot receive a content-type #{response.content_type}"
      raise ArgumentError.new(message)
    end
  end
end
