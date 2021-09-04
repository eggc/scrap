# frozen_string_literal: true

RSpec.describe Scrap::Response do
  describe 'content_type' do
    subject { Scrap::Response.new(Faraday.get(url)) }

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
        Scrap::Response.new(Faraday.get(url)).save_to("#{dir}/img.png")
        expect(File.new("#{dir}/img.png").size).to be_positive
      end
    end
  end
end
