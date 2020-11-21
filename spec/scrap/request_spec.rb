RSpec.describe Scrap::Request do
  let(:url) { 'https://www.google.co.jp' }

  describe 'cache_or_request' do
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
end
