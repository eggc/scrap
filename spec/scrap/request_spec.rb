# frozen_string_literal: true

RSpec.describe Scrap::Fetcher do
  describe 'fetch' do
    context 'follow redirect' do
      let(:url) { 'https://google.co.jp' }

      it 'return html element' do
        response = described_class.instance.fetch(url)
        expect(response.status).to eq(200)
        expect(response).to be_html
      end
    end
  end
end
