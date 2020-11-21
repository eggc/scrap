# frozen_string_literal: true

RSpec.describe Scrap::Fetcher do
  describe 'call' do
    context 'follow redirect' do
      it 'return html element' do
        response = described_class.call('https://google.co.jp')
        expect(response.status).to eq(200)
        expect(response).to be_html
      end
    end

    context 'reuse host and scheme' do
      it do
        described_class.call('https://www.google.co.jp')
        response = described_class.call('/search?q=test')
        expect(response.status).to eq(200)
        expect(response).to be_html
      end
    end
  end
end
