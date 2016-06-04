require 'rails_helper'
require 'capybara/poltergeist'

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end

RSpec.configure do |config|
  config.use_transactional_fixtures = false


  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  Capybara.javascript_driver = :poltergeist
  Capybara.default_max_wait_time = 5
end
