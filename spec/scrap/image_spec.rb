RSpec.describe Scrap::Image do
  describe 'save' do
    it do
      Dir.chdir('/tmp') do |dir|
        image = Scrap::Image.new('test.png', 'xxx')
        image.save
        expect(File.read('test.png')).to eq('xxx')
      end
    end
  end
end
