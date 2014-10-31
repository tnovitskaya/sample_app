class SessionsController < ApplicationController

  def new    
  end

  def create
    user = User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      sign_in user
      redirect_back_or user
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end   
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_url
  end

end
