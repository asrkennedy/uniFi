require 'test_helper'

class SharingPreferencesControllerTest < ActionController::TestCase
  setup do
    @sharing_preference = sharing_preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sharing_preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sharing_preference" do
    assert_difference('SharingPreference.count') do
      post :create, sharing_preference: { name: @sharing_preference.name }
    end

    assert_redirected_to sharing_preference_path(assigns(:sharing_preference))
  end

  test "should show sharing_preference" do
    get :show, id: @sharing_preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sharing_preference
    assert_response :success
  end

  test "should update sharing_preference" do
    put :update, id: @sharing_preference, sharing_preference: { name: @sharing_preference.name }
    assert_redirected_to sharing_preference_path(assigns(:sharing_preference))
  end

  test "should destroy sharing_preference" do
    assert_difference('SharingPreference.count', -1) do
      delete :destroy, id: @sharing_preference
    end

    assert_redirected_to sharing_preferences_path
  end
end
