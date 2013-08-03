class UserNetworksController < ApplicationController

    before_filter :authenticate_user!

  # GET /user_networks
  # GET /user_networks.json
  def index
    @user_networks = UserNetwork.all

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
    @user = current_user
    @user_network.wifi_network ||= WifiNetwork.new

    respond_to do |format|
      format.html # new.html.haml
      format.json { render json: @user_network }
    end
  end

  # GET /user_networks/1/edit
  def edit
    @user_network = UserNetwork.find(params[:id])
    @user = current_user
  end

  # POST /user_networks
  # POST /user_networks.json
  def create
    wifi_network_hash = {
      ssid: params[:user_network]["wifi_network_attributes"]["ssid"],
      password: params[:user_network]["wifi_network_attributes"]["password"],
      postcode: params[:user_network]["wifi_network_attributes"]["postcode"]
    }
    existing_wifi_network = WifiNetwork.where(wifi_network_hash).first
    # params[:user_network]["wifi_network_attributes"]["id"] = existing_wifi_network.id.to_s if existing_wifi_network


    @user_network = UserNetwork.new(params[:user_network])
    @user_network.wifi_network_id = existing_wifi_network.id
    binding.pry
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
