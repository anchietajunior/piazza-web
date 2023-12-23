require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:jerry)
  end

  test "user is logged in and redirect to home with correct credentials" do
    assert_difference("@user.app_sessions.count", 1) { 
      log_in(@user)
    }

    assert_not_empty cookies[:app_session]
    assert_redirected_to root_path
  end

  test "error is rendered for login with incorrect credentials" do
    post login_path, params: { 
      user: {
        email: "jerry@example.com",
        password: "WRONG"
      }
    }

    assert_select ".notification.is-danger", text: I18n.t("sessions.create.incorrect_details")
  end
end
