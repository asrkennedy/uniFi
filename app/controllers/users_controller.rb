$debug = false
class UsersController < ApplicationController
  before_filter :authenticate_user!, skip: [:new, :create]


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

  def friend_add_relationship
    @user = User.find(params[:id])
    @user.make_friendship(current_user, @user, params[:sharing_preferences])
    binding.pry if $debug
    friend_name = @user.first_name + " " + @user.last_name
    redirect_to friendships_path, notice: "You and #{friend_name} are now friends."
  end

end

