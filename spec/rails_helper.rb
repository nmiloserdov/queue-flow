# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'pundit/rspec'
require 'pundit/matchers'

#require automaticly spec files
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

if ENV['LOG'].present?
  Rails.logger = ActiveRecord::Base.logger = Logger.new(STDOUT)
end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include Devise::TestHelpers, type: :controller
  config.extend  ControllerMacros,    type: :controller
  config.include AcceptanceHelper,    type: :feature
  config.include SphinxHelpers,       type: :feature

  config.include JsonSpec::Helpers

  config.include Devise::TestHelpers, type: :controller #devise
  
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
  config.use_transactional_fixtures = true 

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end



Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
