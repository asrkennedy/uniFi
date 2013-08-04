$debug = false
class UsersController < ApplicationController
  before_filter :authenticate_user!, skip: [:new, :create]
  load_and_authorize_resource

  def show
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
    @user.make_friendship(current_user, @user, params[:sharing_preferences])
    friend_name = @user.first_name + " " + @user.last_name
    redirect_to friendships_path, notice: "You and #{friend_name} are now friends."
  end

  def friend_confirm_relationship
    @user = User.find(params[:id])
    @user.confirm_friendship(current_user, @user, params[:sharing_preferences])
    friend_name = @user.first_name + " " + @user.last_name
    redirect_to friendships_path, notice: "You have confirmed your friendship with #{friend_name}."
  end

  def deny_friend
    @user = User.find(params[:id])
    @user.deny_friendship(current_user, @user)
    friend_name = @user.first_name + " " + @user.last_name
    redirect_to friendships_path, notice: "You have rejected #{friend_name}'s friend request."
  end

  def defriend
    @user = User.find(params[:id])
    @user.defriend(current_user, @user)
    friend_name = @user.first_name + " " + @user.last_name
    redirect_to friendships_path, notice: "You have defriended #{friend_name}."
  end

end

