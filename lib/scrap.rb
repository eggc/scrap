# frozen_string_literal: true

require 'dry-configurable'
require 'zeitwerk'

loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect('html' => 'HTML')
loader.setup

# Scrap provides the ability to retrieve arbitrary elements of a website.
class Scrap
  extend Dry::Configurable

  setting :working_directory, default: '/tmp/scrap/', constructor: proc { |v| Pathname.new(v) }

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
      raise ArgumentError, message
    end
  end
end
