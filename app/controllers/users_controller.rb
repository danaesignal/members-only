class UsersController < ApplicationController
  before_action :logged_in_only, only: [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "It's good."
      redirect_to @user
    else
      flash.now[:danger] = "No bueno."
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation)
  end

  def logged_in_only
    redirect_to root_path unless logged_in?
  end
end
