class UserNetworksController < ApplicationController
    load_and_authorize_resource

    prepend_before_filter :remove_wifi_network_id_from_params, only: [:create]
    # before_filter :authenticate_user!

  # GET /user_networks
  # GET /user_networks.json
  def index
    @map = true
    unless current_user
      if !params[:distance].blank?
        unless params[:postcode].blank?
          @all_networks = WifiNetwork.near(params[:postcode].delete(' ').upcase, params[:distance].to_f)
        end
      else
        @all_networks = WifiNetwork.all
      end

      @all_networks_hashes_array = []
      @all_networks.each do |wifi_network|
        network_hash = {
          wifi_network_id: wifi_network.id,
          ssid: "hidden",
          password: "hidden",
          password_required: wifi_network.password_required,
          address: "hidden",
          longitude: wifi_network.longitude,
          latitude: wifi_network.latitude,
          average_user_rating: "hidden",
          updated_at: wifi_network.updated_at
        }
        @all_networks_hashes_array << network_hash
      end

      @empty_array = []
      @all_users_visible_networks = {
        public_networks: @all_networks_hashes_array,
        users_friends_networks: @empty_array,
        users_networks: @empty_array,
        }


    end


    if current_user
      if !params[:distance].blank?
        unless params[:postcode].blank?
          @wifi_networks_in_range = WifiNetwork.near(params[:postcode].delete(' ').upcase, params[:distance].to_f)
          @public_networks = @wifi_networks_in_range.select {|network| network.is_public}.select {|wifi_network| wifi_network.is_not_a_user_network_of(current_user)}
          @users_wifi_networks = @wifi_networks_in_range.joins(:user_networks).where(user_networks: {user_id: current_user.id})
          @users_networks = @users_wifi_networks.map{|wifi_network| wifi_network.user_networks.first}
          @users_friends_networks = (current_user.friends_visible_networks).select {|wifi_network| wifi_network.is_not_a_user_network_of(current_user)}.select{|wifi_network| wifi_network.distance_to(params[:postcode].delete(' ').upcase) <= (params[:distance].to_f)}
        end
      else
        @wifi_networks_in_range = WifiNetwork.all
        @public_networks = @wifi_networks_in_range.select {|wifi_network| wifi_network.is_public}.select {|wifi_network| wifi_network.is_not_a_user_network_of(current_user)}
        @users_networks = UserNetwork.where(user_id: current_user.id)
        @users_friends_networks = (current_user.friends_visible_networks).select {|wifi_network| wifi_network.is_not_a_user_network_of(current_user)}

      end


      @params =params

      @proposers_of_unconfirmed_friendships = current_user.find_unconfirmed_friendships

  # build custom API
      @user_networks_hashes_array = []
      @users_networks.each do |user_network|
        network_hash = {
          id: user_network.id,
          nickname: user_network.nickname,
          user_score: user_network.user_score,
          user_sharing_pref: user_network.user_sharing_pref,
          user_name: user_network.user.full_name,
          wifi_network_id: user_network.wifi_network.id,
          ssid: user_network.wifi_network.ssid,
          password:user_network.wifi_network.password,
          password_required: user_network.wifi_network.password_required,
          address: user_network.wifi_network.full_street_address,
          longitude: user_network.wifi_network.longitude,
          latitude: user_network.wifi_network.latitude,
          average_user_rating: user_network.wifi_network.average_user_rating,
          updated_at: user_network.wifi_network.updated_at
        }

        unless network_hash[:password_required]
          network_hash[:password] = "Not Required"
        end

        @user_networks_hashes_array << network_hash
      end

      @users_friends_networks_hashes_array = []
      @users_friends_networks.each do |wifi_network|
        network_hash = {
          wifi_network_id: wifi_network.id,
          ssid: wifi_network.ssid,
          password:wifi_network.password,
          password_required: wifi_network.password_required,
          address: wifi_network.full_street_address,
          longitude: wifi_network.longitude,
          latitude: wifi_network.latitude,
          average_user_rating: wifi_network.average_user_rating,
          updated_at: wifi_network.updated_at,
          shared_by: wifi_network.user_networks.map do |user_network|
                              if user_network.shareable_with(current_user)
                                user_network.user.full_name
                              end
                            end
        }

         unless network_hash[:password_required]
          network_hash[:password] = "Not Required"
        end


        @users_friends_networks_hashes_array << network_hash
      end

      @public_networks_hashes_array = []
      @public_networks.each do |wifi_network|
        network_hash = {
          wifi_network_id: wifi_network.id,
          ssid: wifi_network.ssid,
          password:wifi_network.password,
          password_required: wifi_network.password_required,
          address: wifi_network.full_street_address,
          longitude: wifi_network.longitude,
          latitude: wifi_network.latitude,
          average_user_rating: wifi_network.average_user_rating,
          updated_at: wifi_network.updated_at
        }
         unless network_hash[:password_required]
          network_hash[:password] = "Not Required"
        end
        @public_networks_hashes_array << network_hash
      end

      @all_users_visible_networks = {
        users_networks: @user_networks_hashes_array,
        users_friends_networks: @users_friends_networks_hashes_array,
        public_networks: @public_networks_hashes_array
        }
    end

    @all_users_visible_networks["current_user_boolean"] = !!current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @all_users_visible_networks }
    end
  end

  # GET /user_networks/1
  # GET /user_networks/1.json
  def show
    @user_network = UserNetwork.find(params[:id])

    @network_hash = {
          id: @user_network.id,
          nickname: @user_network.nickname,
          user_score: @user_network.user_score,
          user_sharing_pref: @user_network.user_sharing_pref,
          user_name: @user_network.user.full_name,
          wifi_network_id: @user_network.wifi_network.id,
          ssid: @user_network.wifi_network.ssid,
          password: @user_network.wifi_network.password,
          password_required: @user_network.wifi_network.password_required,
          address: @user_network.wifi_network.full_street_address,
          longitude: @user_network.wifi_network.longitude,
          latitude: @user_network.wifi_network.latitude,
          average_user_rating: @user_network.wifi_network.average_user_rating,
          updated_at: @user_network.wifi_network.updated_at
        }





    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @network_hash }
    end
  end

  # GET /user_networks/new
  # GET /user_networks/new.json
  def new

    @user_network = UserNetwork.new
    @user_network.wifi_network = WifiNetwork.where(id: params[:wifi_network_id]).first || WifiNetwork.new

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
      format.html { redirect_to user_path(current_user) }
      format.json { head :no_content }
    end
  end

def remove_wifi_network_id_from_params
  params[:user_network][:wifi_network_attributes].delete(:id) rescue nil
end

end
