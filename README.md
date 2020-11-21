# Scrap

scrap はコマンドラインでウェブサイトの任意要素を取り出す機能を提供する。コマンドラインで使用することもできるし、ruby スクリプトの中で使用することもできる。

## Installation

コマンドラインで利用する場合はソースコードをダウンロードして実行する。

```sh
git clone git@github.com:eggc/scrap.git
cd scrap
bundle install
```

プロジェクトの Gemfile に下記の一行を記入して bundle install を実行すれば、ruby スクリプトから呼び出すことができる。

```ruby
gem 'scrap', git: 'git@github.com:eggc/scrap.git'
```

## Usage


たとえば利用例: github.com のタグ `<img>` を抜き出すには下記のようにする。

```sh
bin/scrap --url https://github.com/ --selector img
```

ruby スクリプトとして使用する場合も同様に実行できる。

```ruby
elements = Scrap.fetch(url: "https://github.com/", selector: "img")
elements.each do |element|
  puts element.attr("src")
end
```

## Development

開発時は bin/console を使って対話的コンソールを使いながらデバッグできる。

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eguchi-ken/scrap. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/eguchi-ken/scrap/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Scrap project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/eguchi-ken/scrap/blob/master/CODE_OF_CONDUCT.md).
