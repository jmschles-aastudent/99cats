class UsersController < ApplicationController

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to new_session_url
    else
      flash[:error] ||= []
      flash[:error] << "Invalid username/password combination."
      render :new
    end
  end

  def new
  end
end
