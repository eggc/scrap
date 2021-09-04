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
  end

  describe 'fetch' do
    it do
      @fetcher = described_class.new('www.google.co.jp')

      response = @fetcher.fetch('/search?q=test')
      expect(response.status).to eq(200)
      expect(response).to be_html

      response = @fetcher.fetch('/search?q=test2')
      expect(response.status).to eq(200)
      expect(response).to be_html

      expect(@fetcher.cookie).to be_a(String)
    end
  end
end
