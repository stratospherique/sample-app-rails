class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(creating_params)
    if @user.save
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  private
  def creating_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
