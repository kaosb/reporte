class UsersController < ApplicationController

  def new
    @user = User.new
    render :layout => 'login'
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render :new
    end
  end

end