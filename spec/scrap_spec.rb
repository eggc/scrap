# frozen_string_literal: true

RSpec.describe Scrap do
  describe 'get' do
    context 'content_type = html' do
      it 'return HTML' do
        html = described_class.new('google.com').get('/')
        expect(html).to be_a(Scrap::HTML)
      end
    end

    context 'content_type = image' do
      it 'return Image' do
        image = described_class.new('via.placeholder.com').get('/150')
        expect(image).to be_a(Scrap::Image)
      end
    end
  end
end
