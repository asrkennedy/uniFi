require 'test_helper'

class UserNetworksControllerTest < ActionController::TestCase
  setup do
    @user_network = user_networks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_networks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_network" do
    assert_difference('UserNetwork.count') do
      post :create, user_network: { nickname: @user_network.nickname, user_id: @user_network.user_id, user_score: @user_network.user_score, user_sharing_pref: @user_network.user_sharing_pref, wifi_network_id: @user_network.wifi_network_id }
    end

    assert_redirected_to user_network_path(assigns(:user_network))
  end

  test "should show user_network" do
    get :show, id: @user_network
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_network
    assert_response :success
  end

  test "should update user_network" do
    put :update, id: @user_network, user_network: { nickname: @user_network.nickname, user_id: @user_network.user_id, user_score: @user_network.user_score, user_sharing_pref: @user_network.user_sharing_pref, wifi_network_id: @user_network.wifi_network_id }
    assert_redirected_to user_network_path(assigns(:user_network))
  end

  test "should destroy user_network" do
    assert_difference('UserNetwork.count', -1) do
      delete :destroy, id: @user_network
    end

    assert_redirected_to user_networks_path
  end
end
