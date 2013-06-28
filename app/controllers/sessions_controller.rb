class SessionsController < ApplicationController

  def new
    render :layout => 'login'
  end

  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_url, :notice => "Ya te autenticaste!"
    else
      flash[:error] = "Email o Password incorrecto."
      redirect_to new_session_path
    end
  end

  def destroy
  	session[:user_id] = nil
    render :layout => 'login'
  end

end