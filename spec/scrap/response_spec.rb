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

  describe 'file_name' do
    subject { response.file_name }
    let(:url) { 'https://via.placeholder.com/150' }
    it { should eq('150') }
  end
end
