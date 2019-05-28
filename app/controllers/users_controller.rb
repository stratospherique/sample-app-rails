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
      log_in @user
      flash[:success]= "Welcome to the sample app"
      redirect_to @user
    else
      render 'new'
    end
  end

  private
  def creating_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
