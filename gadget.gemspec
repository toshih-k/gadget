# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'gadget/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'gadget'
  spec.version     = Gadget::VERSION
  spec.authors     = ['Toshihisa KATO']
  spec.email       = ['toshihk@gmail.com']
  spec.homepage    = 'https://github.com/toshih-k'
  spec.summary     = 'GraphQL / Activerecord Dynamic GEneraTor.'
  spec.description = 'Generate GraphQL Query/Mutation from ActiveRecord.'
  spec.license     = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against ' \
      'public gem pushes.'
  end

  spec.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  spec.add_dependency 'enum_help', '~> 0.0.17', '>= 0.0.17'
  spec.add_dependency 'graphql', '~> 1.11', '>= 1.11.6'
  spec.add_dependency 'kaminari', '~> 1.2', '>= 1.2.1'
  spec.add_dependency 'rails', '>= 4'
  spec.add_dependency 'ransack', '~> 2.3', '>= 2.3.2'
  spec.add_dependency 'ransack-enum', '~> 1.0'

  spec.add_development_dependency 'graphiql-rails'
  spec.add_development_dependency 'graphql'
  spec.add_development_dependency 'kaminari'
  spec.add_development_dependency 'pry-rails'
  spec.add_development_dependency 'ransack'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'rubocop-rails'
  spec.add_development_dependency 'sqlite3'
end
