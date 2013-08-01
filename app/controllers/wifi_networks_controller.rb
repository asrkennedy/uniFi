class WifiNetworksController < ApplicationController
  # GET /wifi_networks
  # GET /wifi_networks.json
  def index
    @wifi_networks = WifiNetwork.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @wifi_networks }
    end
  end

  # GET /wifi_networks/1
  # GET /wifi_networks/1.json
  def show
    @wifi_network = WifiNetwork.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @wifi_network }
    end
  end

  # GET /wifi_networks/new
  # GET /wifi_networks/new.json
  def new
    @wifi_network = WifiNetwork.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @wifi_network }
    end
  end

  # GET /wifi_networks/1/edit
  def edit
    @wifi_network = WifiNetwork.find(params[:id])
  end

  # POST /wifi_networks
  # POST /wifi_networks.json
  def create
    @wifi_network = WifiNetwork.new(params[:wifi_network])

    respond_to do |format|
      if @wifi_network.save
        format.html { redirect_to @wifi_network, notice: 'Wifi network was successfully created.' }
        format.json { render json: @wifi_network, status: :created, location: @wifi_network }
      else
        format.html { render action: "new" }
        format.json { render json: @wifi_network.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /wifi_networks/1
  # PUT /wifi_networks/1.json
  def update
    @wifi_network = WifiNetwork.find(params[:id])

    respond_to do |format|
      if @wifi_network.update_attributes(params[:wifi_network])
        format.html { redirect_to @wifi_network, notice: 'Wifi network was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @wifi_network.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wifi_networks/1
  # DELETE /wifi_networks/1.json
  def destroy
    @wifi_network = WifiNetwork.find(params[:id])
    @wifi_network.destroy

    respond_to do |format|
      format.html { redirect_to wifi_networks_url }
      format.json { head :no_content }
    end
  end
end
