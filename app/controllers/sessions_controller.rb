class SessionsController < ApplicationController
  def index
    @users = User.all
  end

  def create
    session[:user_id] = params[:user_id]

    redirect_to summary_path
  end
end
