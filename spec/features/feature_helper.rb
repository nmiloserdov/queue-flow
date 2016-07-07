require 'rails_helper'
require 'capybara/poltergeist'

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  ThinkingSphinx::Test.init
  ThinkingSphinx::Test.start_with_autostop


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

  # if ENV[‘LOG’].present?
  Capybara.register_driver :poltergeist do |app|
    Capybara::Poltergeist::Driver.new(
      app,
      timeout: 90, js_errors: true,
      phantomjs_logger: Logger.new(STDOUT),
      window_size: [1020, 740]
    )
  end
  Capybara.javascript_driver = :poltergeist
  Capybara.default_max_wait_time = 5
end
