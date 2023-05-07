# frozen_string_literal: true

require 'fileutils'

class Scrap
  class Image
    def initialize(name, content)
      @name = name
      @content = content
    end

    def save
      dir = Scrap.config.working_directory
      FileUtils.mkdir_p(dir)
      File.open(dir.join(@name), 'wb') do |file|
        file.write(@content)
      end
    end
  end
end
