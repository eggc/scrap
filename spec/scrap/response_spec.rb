# frozen_string_literal: true

RSpec.describe Scrap::Response do
  let(:response) { Scrap::Response.new(Faraday.get(url)) }

  describe 'content_type' do
    subject { response }

    context 'html' do
      let(:url) { 'https://google.co.jp' }
      it { should be_html }
    end

    context 'image' do
      let(:url) { 'https://via.placeholder.com/150' }
      it { should be_image }
    end
  end

  describe 'save_to' do
    let(:url) { 'https://via.placeholder.com/150' }
    it do
      Dir.mktmpdir do |dir|
        response.save_to("#{dir}/img.png")
        expect(File.new("#{dir}/img.png").size).to be_positive
      end
    end
  end

  describe 'query' do
    subject { response.query('img', 'src') }

    context 'selector and attribute' do
      let(:url) { 'https://www.google.com/' }
      it { should be_any }
    end
  end
end
