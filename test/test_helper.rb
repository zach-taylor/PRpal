ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'
require 'mocha/mini_test'
#require 'trailblazer/rails/test/integration'
require 'minitest/rails/capybara'
require 'support/session_helper'
require 'support/github_helper'
require 'capybara/dsl'

OmniAuth.configure do |config|
  config.test_mode = true
end

Cell::TestCase.class_eval do
  include Capybara::DSL
  include Capybara::Assertions
end

Capybara::Rails::TestCase.class_eval do
  include SessionHelper
end

module ActiveSupport
  class TestCase
    include GithubHelper

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all
  end
end
