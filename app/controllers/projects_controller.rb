class ProjectsController < ApplicationController
  def index
    redirect_to admin_path if session[:admin]
    @projects = Project.all
  end
end
