RSpec.describe Scrap::Request do
  describe 'request' do
    context 'follow redirect' do
      let(:url) { 'https://google.co.jp' }

      it 'return html element' do
        response = described_class.new(url).request
        expect(response.status).to eq(200)
      end
    end
  end
end
