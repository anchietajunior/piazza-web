ENV["RAILS_ENV"] ||= "test"

require_relative "../config/environment"
require "rails/test_help"
require "capybara/rails"
require "capybara/minitest"
require "selenium-webdriver"

Dir[Rails.root.join("test", "support", "**", "*.rb")].each {
  |f| require f
}

# 120.0.6099.109

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include AuthenticationHelpers
  include RoutesHelpers
end

