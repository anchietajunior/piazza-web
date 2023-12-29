require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  WINDOW_SIZE = [1400, 1400]
  driven_by :selenium, using: :chrome, screen_size: WINDOW_SIZE

  private

  def log_in(user, password: "password")
    visit login_path

    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: user.password
  end
end

class MobileSystemTestCase < ApplicationSystemTestCase
  setup do
    visit root_path
    current_window.resize_to(375, 812)
  end

  teardown do
    current_window.resize_to(*ApplicationSystemTestCase::WINDOW_SIZE)
  end
end
