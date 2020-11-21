RSpec.describe Scrap::Fetch do
  describe '.call' do
    context 'without attribute' do
      it 'returns elements' do
        elements = described_class.call(url: 'https://www.google.co.jp', selector: 'img')
        expect(elements.size).to be > 0
        expect(elements).to all(be_a(Nokogiri::XML::Element))
      end
    end

    context 'with attribute' do
      it 'returns attributes' do
        attributes = described_class.call(url: 'https://www.google.co.jp', selector: 'img', attribute: 'src')
        expect(attributes.size).to be > 0
        expect(attributes).to all(be_a(String))
      end
    end
  end
end
