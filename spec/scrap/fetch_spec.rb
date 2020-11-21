RSpec.describe Scrap::Fetch do
  let(:url) { 'https://www.google.co.jp' }

  describe '.call' do
    context 'without attribute' do
      it 'returns elements' do
        elements = described_class.call(url: url, selector: 'img')
        expect(elements.size).to be > 0
        expect(elements).to all(be_a(Nokogiri::XML::Element))
      end
    end

    context 'with attribute' do
      it 'returns attributes' do
        attributes = described_class.call(url: url, selector: 'img', attribute: 'src')
        expect(attributes.size).to be > 0
        expect(attributes).to all(be_a(String))
      end
    end

    context 'verbose' do
      it 'print message' do
        expect do
          described_class.verbose = true
          described_class.call(url: url, selector: 'img')
        end.to output(/^fetch /).to_stdout
      end
    end
  end

  describe 'cache_or_request'
  context '2nd request' do
    before { Scrap::Cache.clear }

    it do
      allow(described_class).to receive(:request).and_return('some response')
      described_class.send(:cache_or_request, url, 'cookie')
      described_class.send(:cache_or_request, url, 'cookie')
      expect(described_class).to have_received(:request).once
    end
  end
end
