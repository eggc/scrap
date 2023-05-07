# frozen_string_literal: true

require 'rmagick'

class Scrap
  # Scrap::ImageCoverter converts image binary size and format
  class ImageConverter
    attr_accessor :image

    def initialize(binary)
      self.image = Magick::Image.from_blob(binary).first
    end

    def width
      image.columns
    end

    def height
      image.rows
    end

    def resolution
      [
        image.x_resolution,
        image.y_resolution
      ]
    end

    def write(path)
      image.change_geometry!(Scrap.config.pixel_width) do |cols, rows, img|
        img.density = "72x72"
        img.resize_to_fit!(cols, rows)
      end

      image.strip!
      image.write(path)
    end
  end
end
