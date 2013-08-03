class UserNetworksController < ApplicationController

    before_filter :authenticate_user!

  # GET /user_networks
  # GET /user_networks.json
  def index

    @users_networks = UserNetwork.where(user_id: current_user.id)
    @users_friends_networks = current_user.friends_visible_networks
    @proposers_of_unconfirmed_friendships = current_user.find_unconfirmed_friendships

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_networks }
    end
  end

  # GET /user_networks/1
  # GET /user_networks/1.json
  def show
    @user_network = UserNetwork.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_network }
    end
  end

  # GET /user_networks/new
  # GET /user_networks/new.json
  def new
    @user_network = UserNetwork.new
    @user_network.wifi_network ||= WifiNetwork.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @user_network }
    end
  end

  # GET /user_networks/1/edit
  def edit
    @user_network = UserNetwork.find(params[:id])
  end

  # POST /user_networks
  # POST /user_networks.json
  def create
    params[:user_network]["wifi_network_attributes"]["postcode"] = params[:user_network]["wifi_network_attributes"]["postcode"].delete(' ').upcase

    wifi_network_hash = {
      ssid: params[:user_network]["wifi_network_attributes"]["ssid"],
      postcode: params[:user_network]["wifi_network_attributes"]["postcode"],
      password: params[:user_network]["wifi_network_attributes"]["password"]
    }
    existing_wifi_network = WifiNetwork.where(wifi_network_hash).first

    @user_network = UserNetwork.new(params[:user_network])
    @user_network.wifi_network_id = existing_wifi_network.id if existing_wifi_network

    respond_to do |format|
      if @user_network.save
        format.html { redirect_to @user_network, notice: 'User network was successfully created.' }
        format.json { render json: @user_network, status: :created, location: @user_network }
      else
        format.html { render action: "new" }
        format.json { render json: @user_network.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_networks/1
  # PUT /user_networks/1.json
  def update
    params[:user_network]["wifi_network_attributes"]["postcode"] = params[:user_network]["wifi_network_attributes"]["postcode"].delete(' ').upcase
    @user_network = UserNetwork.find(params[:id])
    respond_to do |format|
      if @user_network.update_attributes(params[:user_network])
        format.html { redirect_to @user_network, notice: 'User network was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_network.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_networks/1
  # DELETE /user_networks/1.json
  def destroy
    @user_network = UserNetwork.find(params[:id])
    @user_network.destroy

    respond_to do |format|
      format.html { redirect_to user_networks_url }
      format.json { head :no_content }
    end
  end
end
