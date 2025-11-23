require "test_helper"

class Admin::DatabaseAuthentication::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @admin = admins(:one)
    @auth = admin_database_authentications(:one)
  end

  # POST /admin (新規登録)
  test "should create admin and database_authentication with valid params" do
    assert_difference([ "Admin.count", "Admin::DatabaseAuthentication.count" ], 1) do
      post admin_database_authentication_registration_path, params: {
        admin_database_authentication: {
          email: "newadmin@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_response :redirect
  end

  test "should associate database_authentication with admin" do
    post admin_database_authentication_registration_path, params: {
      admin_database_authentication: {
        email: "newadmin@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    auth = Admin::DatabaseAuthentication.find_by(email: "newadmin@example.com")
    assert_not_nil auth.admin
    assert_equal auth.admin_id, auth.admin.id
  end

  test "should sign in after registration" do
    post admin_database_authentication_registration_path, params: {
      admin_database_authentication: {
        email: "newadmin@example.com",
        password: "password123",
        password_confirmation: "password123"
      }
    }

    assert_not_nil session["warden.user.admin_database_authentication.key"]
  end

  test "should not create with invalid email" do
    assert_no_difference([ "Admin.count", "Admin::DatabaseAuthentication.count" ]) do
      post admin_database_authentication_registration_path, params: {
        admin_database_authentication: {
          email: "invalid",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    # バリデーションエラーは422を返す
    assert_response :unprocessable_entity
  end

  test "should not create with mismatched passwords" do
    assert_no_difference([ "Admin.count", "Admin::DatabaseAuthentication.count" ]) do
      post admin_database_authentication_registration_path, params: {
        admin_database_authentication: {
          email: "admin@example.com",
          password: "password123",
          password_confirmation: "different"
        }
      }
    end

    # バリデーションエラーは422を返す
    assert_response :unprocessable_entity
  end

  # DELETE /admin (アカウント削除)
  test "should destroy database_authentication and admin" do
    sign_in @auth

    # Registrationも削除されることを確認
    assert_difference([ "Admin.count", "Admin::DatabaseAuthentication.count", "Admin::Registration.count" ], -1) do
      delete admin_database_authentication_registration_path
    end

    assert_response :redirect
  end

  test "should sign out after account deletion" do
    sign_in @auth

    delete admin_database_authentication_registration_path

    assert_nil session["warden.user.admin_database_authentication.key"]
  end
end
