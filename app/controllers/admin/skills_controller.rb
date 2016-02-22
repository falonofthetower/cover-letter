class Admin::SkillsController < AdminController
  def index
    @skills = Skill.all
    @admin = true
  end

  def new
    @skill = Skill.new
  end

  def create
    @skill = Skill.new(skill_params)
    if @skill.save
      flash[:success] = "Saved!"
      redirect_to skills_path
    else
      flash[:danger] = "Your submission has failed!"
      render :new
    end
  end

  def edit
    @skill = Skill.find(params[:id])
  end

  def update
    @skill = Skill.find(params[:id])
    if @skill.update(skill_params)
      redirect_to skills_path
      flash[:success] = "Skill updated"
    else
      render :edit
    end
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy
    flash[:danger] = "Another one bites the dust!"
    redirect_to skills_path
  end

  private

  def skill_params
    params.require(:skill).permit(
      :title,
      :text,
      :weight
    )
  end
end
