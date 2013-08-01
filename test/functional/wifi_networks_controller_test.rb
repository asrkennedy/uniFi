require 'test_helper'

class WifiNetworksControllerTest < ActionController::TestCase
  setup do
    @wifi_network = wifi_networks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wifi_networks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wifi_network" do
    assert_difference('WifiNetwork.count') do
      post :create, wifi_network: { lat: @wifi_network.lat, lng: @wifi_network.lng, password: @wifi_network.password, password_required: @wifi_network.password_required, postcode: @wifi_network.postcode, score: @wifi_network.score, ssid: @wifi_network.ssid, street_address: @wifi_network.street_address }
    end

    assert_redirected_to wifi_network_path(assigns(:wifi_network))
  end

  test "should show wifi_network" do
    get :show, id: @wifi_network
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wifi_network
    assert_response :success
  end

  test "should update wifi_network" do
    put :update, id: @wifi_network, wifi_network: { lat: @wifi_network.lat, lng: @wifi_network.lng, password: @wifi_network.password, password_required: @wifi_network.password_required, postcode: @wifi_network.postcode, score: @wifi_network.score, ssid: @wifi_network.ssid, street_address: @wifi_network.street_address }
    assert_redirected_to wifi_network_path(assigns(:wifi_network))
  end

  test "should destroy wifi_network" do
    assert_difference('WifiNetwork.count', -1) do
      delete :destroy, id: @wifi_network
    end

    assert_redirected_to wifi_networks_path
  end
end
