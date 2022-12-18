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
      let(:url) { 'https://images.dog.ceo/breeds/bluetick/n02088632_2736.jpg' }
      it { should be_image }
    end
  end

  describe 'file_name' do
    subject { response.file_name }
    let(:url) { 'https://images.dog.ceo/breeds/bluetick/n02088632_2736.jpg' }
    it { should eq('n02088632_2736.jpg') }
  end
end
