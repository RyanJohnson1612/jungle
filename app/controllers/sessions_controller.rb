class SessionsController < ApplicationController

  def create
    if user = User.authenticate_with_credentials(params[:login][:email], params[:login][:password])
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
