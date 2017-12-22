class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      flash[:success] = "It's good."
      redirect_to root_path
    else
      flash[:danger] = "No bueno."
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation)
      end
end
