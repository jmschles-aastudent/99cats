class SessionsController < ApplicationController
  def create
    user = User.find_by_username(params[:username])
    if user && user.password == params[:password]
      user.session_token = generate_token
      user.save!
      session[:session_token] = user.session_token
      redirect_to cats_url
    else
      flash[:errors] ||= []
      flash[:errors] << "Invalid username/password combination"
      redirect_to new_session_url
    end
  end

  def new
  end

  def destroy
    session[:session_token] = nil
    # @current_user = nil
    redirect_to new_session_url
  end

  private

  def generate_token
    SecureRandom.urlsafe_base64
  end
end
