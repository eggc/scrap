# frozen_string_literal: true

RSpec.describe Scrap do
  describe 'fetch' do
    it 'return html element' do
      elements = described_class.fetch(url: 'https://google.co.jp', selector: 'body')
      expect(elements.size).to be > 0
      expect(elements).to all(be_a(Nokogiri::XML::Element))
    end
  end
end
