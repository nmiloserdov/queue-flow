source 'https://rubygems.org'

ruby '2.3.0'

gem 'rails', '4.2.6'
gem 'pg', '~> 0.15'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

gem "responders"

gem 'rubocop', require: false

# layout
gem "slim"
gem "slim-rails"
gem "therubyracer" # compile coffee while deployment
gem "less-rails"               
gem "twitter-bootstrap-rails"   
gem 'formtastic'
gem 'cocoon'
gem "font-awesome-rails"
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'will_paginate', '~> 3.1.0'

gem 'faker'

# json
gem 'active_model_serializers'
gem 'oj'
gem 'oj_mimic_json'

# upload
gem 'carrierwave'
gem 'remotipart'

# readltime
gem 'private_pub'
gem 'thin'

# authentication
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'pundit'
gem 'doorkeeper'

# parallelization
gem 'sidekiq'
gem 'sinatra', '>= 1.3.0', require: nil

# cron
# gem 'sidetiq'
gem 'whenever'

# search
gem 'mysql2'
gem 'thinking-sphinx'

# deploy
gem 'dotenv'
gem 'dotenv-deployment', require: 'dotenv/deployment'

gem 'unicorn'

# cache
gem 'redis-rails'

group :test do
  gem 'shoulda-matchers', '~> 3.1'
  gem 'pundit-matchers', '~> 1.1.0'
  gem 'capybara'
  gem 'capybara-json'
  gem 'capybara-email'
  gem 'json_spec'
  gem 'launchy'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'byebug'
  gem 'poltergeist'
  gem "letter_opener"
  # workflow
  gem 'guard-rails'
  gem 'guard-livereload', '~> 2.5', require: false
  gem 'guard-redis'
  gem 'guard-sidekiq'
  # deploy
  gem 'capistrano',          require: false
  gem 'capistrano-bundler',  require: false
  gem 'capistrano-rails',    require: false
  gem 'capistrano-rbenv',    require: false
  gem 'capistrano-sidekiq',  require: false
  gem 'capistrano3-unicorn', require: false
end

group :development do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'pry-rails'
end
