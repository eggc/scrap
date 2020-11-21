# frozen_string_literal: true

RSpec.describe Scrap::Filter do
  before(:all) do
    @html = Scrap::Request.call('https://www.google.co.jp')
  end

  describe '.call' do
    context 'without attribute' do
      it 'returns elements' do
        elements = described_class.call(html: @html, selector: 'img')
        expect(elements.size).to be > 0
        expect(elements).to all(be_a(Nokogiri::XML::Element))
      end
    end

    context 'with attribute' do
      it 'returns attributes' do
        attributes = described_class.call(html: @html, selector: 'img', attribute: 'src')
        expect(attributes.size).to be > 0
        expect(attributes).to all(be_a(String))
      end
    end

    context 'verbose' do
      it 'print message' do
        expect do
          described_class.verbose = true
          described_class.call(html: @html, selector: 'img')
        end.to output(/^filter /).to_stdout
      end
    end
  end
end
