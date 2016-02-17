class SessionsController < ApplicationController
  def new; end

  def create
    if params[:password] == ENV["SECRET"]
      session[:admin] = true
      redirect_to root_path
    else
      flash.now[:danger] = "Not the secret"
      session[:admin] = nil
      render :new
    end
  end
end
