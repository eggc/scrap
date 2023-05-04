# frozen_string_literal: true

require_relative 'lib/scrap/version'

Gem::Specification.new do |spec|
  spec.name          = 'scrap'
  spec.version       = Scrap::VERSION
  spec.authors       = ['eggc']
  spec.email         = ['no.eggchicken@gmail.com']

  spec.summary       = 'web scrap'
  spec.description   = 'web scrap'
  spec.homepage      = 'https://github.com/eggc/scrap'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.2.2')

  spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/eggc/scrap'
  spec.metadata['changelog_uri'] = 'https://github.com/eggc/scrap'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 1.0'
  spec.add_dependency 'faraday-cookie_jar', '~> 0.0'
  spec.add_dependency 'faraday_middleware', '~> 1.0'
  spec.add_dependency 'nokogiri', '~> 1.10'
end
