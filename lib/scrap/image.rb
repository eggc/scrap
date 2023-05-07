# frozen_string_literal: true

require 'fileutils'

class Scrap
  # Scrap::Image writes image binary to a file
  class Image
    def initialize(name, binary)
      @name = name
      @binary = binary
    end

    def save
      dir = Scrap.config.working_directory
      FileUtils.mkdir_p(dir)
      Scrap::ImageConverter.new(@binary).write(dir.join(@name))
    end
  end
end
