require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "redirects to feed after sucessful sign up" do
    get sign_up_path
    assert_response :ok

    assert_difference ["User.count", "Organization.count"], 1 do
      post sign_up_path, params: {
        user: {
          name: "Anchieta",
          email: "anchieta@redirect.com",
          password: "password"
        }
      }
    end

    assert_redirected_to root_path
    assert_not_empty cookies[:app_session]

    follow_redirect!
    assert_select ".notification.is-success", text: I18n.t("users.create.welcome", name: "Anchieta")
  end

  test "renders errors if input data is invalid" do
    get sign_up_path
    assert_response :ok

    assert_no_difference ["User.count", "Organization.count"] do
      post sign_up_path, params: {
        user: {
          name: "Anchieta",
          email: "anchieta@redirectto.com",
          password: "pass"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "p.is-danger", text: I18n.t("activerecord.errors.models.user.attributes.password.too_short")
  end

  test "can update user details" do
    @user = users(:jerry)  
    log_in @user


    patch profile_path, params: { user: { name: "Jerry Seinfield" } }

    assert_redirected_to profile_path
    assert_equal "Jerry Seinfield", @user.reload.name
  end
end
