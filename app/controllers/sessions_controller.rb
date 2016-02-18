class SessionsController < ApplicationController
  def new; end

  def create
    if params[:password] == ENV["SECRET"]
      session[:admin] = true
      flash[:success] = "Welcome to Shangri-La"
      redirect_to root_path
    else
      flash.now[:danger] = "Not the secret"
      session[:admin] = nil
      render :new
    end
  end

  def destroy
    session[:admin] = nil
    redirect_to root_path
  end
end
