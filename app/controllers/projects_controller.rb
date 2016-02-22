class ProjectsController < ApplicationController
  def index
    @projects = Project.order(:weight)
  end
end
