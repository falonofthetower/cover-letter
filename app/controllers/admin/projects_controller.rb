class Admin::ProjectsController < AdminController
  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      flash[:success] = "Saved!"
      redirect_to projects_path
    else
      flash[:danger] = "Your submission has failed!"
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    if @project.update(project_params)
      redirect_to projects_path
      flash[:success] = "Project updated"
    else
      render :edit
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    flash[:danger] = "Another one bites the dust!"
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(
      :image_path,
      :text
    )
  end
end
