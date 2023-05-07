# frozen_string_literal: true

RSpec.describe Scrap::Image do
  describe 'save' do
    it do
      image = Scrap::Image.new('test.png', 'xxx')
      image.save
      expect(File.read('/tmp/scrap/test.png')).to eq('xxx')
    end
  end
end
