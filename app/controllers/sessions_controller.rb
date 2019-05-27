class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id]= user.id
      flash[:success] = "Welcome #{user.name}"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Wrong User Credentials!!!"
      render 'new'
    end
  end
end
