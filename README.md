# Scrap

scrap はウェブサイトの任意要素を取り出す機能を提供する。

## Installation

Gemfile に下記の行を書き込み bundle install を実行する。

```ruby
gem 'scrap', git: 'git@github.com:eggc/scrap.git'
```

## Usage


たとえば github.com のタグ `<img>` を抜き出し、画像の URL を取得するには下記のようにする。

```ruby
Scrap.new("github.com").get('/').image_urls
```

## Development

開発時は bin/console を使って対話的コンソールを使いながらデバッグできる。

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/eggc/scrap. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/eggc/scrap/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Scrap project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/eggc/scrap/blob/master/CODE_OF_CONDUCT.md).
