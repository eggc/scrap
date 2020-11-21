RSpec.describe Scrap::Request do
  let(:url) { 'https://www.google.co.jp' }
  let(:instance) { described_class.new(url, 'cookie') }

  describe 'cache_or_request' do
    context '2nd request' do
      before { Scrap::Cache.clear }

      it do
        allow(instance).to receive(:request).and_return('some response')
        2.times { instance.cache_or_request }
        expect(instance).to have_received(:request).once
      end
    end

    context 'follow redirect' do
      let(:url) { 'https://google.co.jp' }

      it 'return html element' do
        response = instance.cache_or_request
        expect(response.status).to eq(200)
      end
    end
  end
end
