class UsersController < ApplicationController
  before_filter :authenticate_user!, skip: [:new, :create]


  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.haml
      format.json { render json: @user }
    end
  end


end

