# frozen_string_literal: true

RSpec.describe Scrap::Image do
  describe 'save' do
    it do
      binary = File.binread('spec/fixtures/image/test.jpeg')
      image = Scrap::Image.new('test', binary)
      image.save
      expect(File.exist?('/tmp/scrap/test')).to eq(true)
    end
  end
end
