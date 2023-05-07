# frozen_string_literal: true

RSpec.describe Scrap::ImageConverter do
  def converter
    Scrap::ImageConverter.new(
      File.binread('spec/fixtures/image/test.jpeg')
    )
  end

  describe 'width' do
    it do
      expect(converter.width).to eq(400)
    end
  end

  describe 'height' do
    it do
      expect(converter.height).to eq(300)
    end
  end

  describe 'resolution' do
    it do
      expect(converter.resolution).to eq([72, 72])
    end
  end

  describe 'write' do
    before { FileUtils.rm_rf('/tmp/out.jpeg') }

    it do
      converter.write('/tmp/out.jpeg')
      new_image = Scrap::ImageConverter.new(File.binread('/tmp/out.jpeg'))
      expect(new_image.width).to eq(2560)
      expect(new_image.height).to eq(1920)
      expect(new_image.resolution).to eq([72, 72])
    end
  end
end
