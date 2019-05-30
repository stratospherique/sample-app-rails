class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update,:index]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

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

  def edit
    
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(creating_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
  def creating_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end

    # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
 
end
