# frozen_string_literal: true

RSpec.describe Scrap::Fetcher do
  describe 'call' do
    context 'follow redirect' do
      it 'return html element' do
        response = described_class.call('https://google.co.jp')
        expect(response.status).to eq(200)
        expect(response).to be_a(Faraday::Response)
      end
    end
  end

  describe 'fetch' do
    it 'can multiple request with cookies' do
      @fetcher = described_class.new('google.co.jp', { '1P_JAR' => '2020-09-02-10' })

      response = @fetcher.fetch('/search?q=test')
      expect(response.status).to eq(200)
      expect(response).to be_a(Faraday::Response)

      response = @fetcher.fetch('/search?q=test2')
      expect(response.status).to eq(200)
      expect(response).to be_a(Faraday::Response)
    end
  end
end
