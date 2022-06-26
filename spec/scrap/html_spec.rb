# frozen_string_literal: true

RSpec.describe Scrap::HTML do
  before do
    @html = described_class.new(<<~HTML)
      <head>
        <title>hogehoge page | home</title>
      </head>
      <body>
        <h1>image</h1>
        <div>
          <img src="hoge/fuga.png">
          <img src="title.jpg">
        </div>
      </body>
    HTML
  end

  describe 'image_urls' do
    it do
      expect(@html.image_urls).to eq(['hoge/fuga.png', 'title.jpg'])
    end
  end

  describe 'title' do
    it do
      expect(@html.title).to eq('hogehoge page | home')
    end
  end
end
