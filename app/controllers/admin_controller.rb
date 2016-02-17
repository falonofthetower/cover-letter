class AdminController < ApplicationController
  before_action :require_admin

  private

  def require_admin
    unless session[:admin]
      flash[:danger] = "You don't have authorization to do that"
      redirect_to root_path
    end
  end
end
