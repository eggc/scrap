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
      File.open(dir.join(@name), 'wb') do |file|
        file.write(@binary)
      end
    end
  end
end
