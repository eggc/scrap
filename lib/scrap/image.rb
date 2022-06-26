class Scrap
  class Image
    def initialize(name, content)
      @name = name
      @content = content
    end

    def save
      File.open(@name, 'wb') do |file|
        file.write(@content)
      end
    end
  end
end
