$debug = false
class UsersController < ApplicationController
  before_filter :authenticate_user!, skip: [:new, :create]
    load_and_authorize_resource


  def index
    @proposers_of_unconfirmed_friendships = current_user.find_unconfirmed_friendships

    @proposers = {
      proposers: @proposers_of_unconfirmed_friendships
    }

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @proposers }
    end
  end


def show
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

    @proposers_of_unconfirmed_friendships = current_user.find_unconfirmed_friendships
    @user = User.find(params[:id])


    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @user }
    end
  end

  def new_friend

    @user = User.find(params[:id])


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friendship }
    end
  end

  def confirm_friend
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friendship }
    end
  end

  def friend_add_relationship
    @user = User.find(params[:id])
    @user.make_friendship(current_user, params[:sharing_preferences])
    sharing_preferences = params[:sharing_preferences]
    friend_name = "#{@user.first_name} #{@user.last_name}"
    redirect_to friendships_path, notice: "You and #{friend_name} are now friends."
  end

 def friend_update_relationship
    @user = User.find(params[:id])
    @user.update_friendship(current_user, params[:sharing_preferences])
    sharing_preferences = params[:sharing_preferences]
    friend_name = "#{@user.first_name} #{@user.last_name}"
    redirect_to friendships_path, notice: "You have labeled #{friend_name} as #{sharing_preferences}"
  end


  def friend_confirm_relationship
    @user = User.find(params[:id])
    @user.confirm_friendship(current_user, @user, params[:sharing_preferences])
    friend_name = "#{@user.first_name} #{@user.last_name}"
    redirect_to friendships_path, notice: "You have confirmed your friendship with #{friend_name}"
  end

  def deny_friend
    @user = User.find(params[:id])
    @user.deny_friendship(current_user, @user)
    friend_name = "#{@user.first_name} #{@user.last_name}"
    redirect_to friendships_path, notice: "You have rejected #{friend_name}'s friend request"
  end

  def defriend
    @user = User.find(params[:id])
    @user.defriend(current_user, @user)
    friend_name = "#{@user.first_name} #{@user.last_name}"
    redirect_to friendships_path, notice: "You have defriended #{friend_name}"
  end

end

