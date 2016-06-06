class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      flash[:success] = "You have sucessfully logged in!"
      session[:user_id] = @user.id
      redirect_to links_path
    else
      flash.now[:danger] = "Invalid Credentials"
      render :new
    end
  end
end
