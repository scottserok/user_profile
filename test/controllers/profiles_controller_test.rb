require "test_helper"

class ProfilesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    sign_in @user
    @profile = @user.profile
  end

  test "should get index" do
    get profiles_url
    assert_response :success
  end

  test "when no profile, should get new" do
    @user = users(:two)
    sign_in @user
    get new_profile_url
    assert_response :success
  end

  test "when profile, should redirect to it" do
    get new_profile_url
    assert_redirected_to profile_url(@user.profile)
  end

  test "when no profile, should create profile" do
    @user = users(:two)
    sign_in @user
    assert_difference('Profile.count') do
      post profiles_url, params: { profile: { locale: @profile.locale, name: @profile.name, timezone: @profile.timezone, user_id: @profile.user_id } }
    end

    assert_redirected_to profile_url(Profile.last)
    profile = Profile.last
    assert_equal(@user, profile.user)
    assert_equal("Scott", profile.name)
    assert_equal("en", profile.locale)
    assert_equal("Etc/GMT+12", profile.timezone)
  end

  test "should show profile" do
    get profile_url(@profile)
    assert_response :success
  end

  test "should get edit" do
    get edit_profile_url(@profile)
    assert_response :success
  end

  test "should update profile" do
    patch profile_url(@profile), params: { profile: { locale: @profile.locale, name: @profile.name, timezone: @profile.timezone, user_id: @profile.user_id } }
    assert_redirected_to profile_url(@profile)
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete profile_url(@profile)
    end

    assert_redirected_to profiles_url
  end
end
