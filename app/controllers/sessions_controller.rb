class SessionsController < ApplicationController
  def index
    @users = User.all
  end

  def create
    session[:user_id] = params[:id]
    redirect_to "/summary"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
