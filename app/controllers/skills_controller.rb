class SkillsController < ApplicationController
  def index
    @skills = Skill.order(:weight)
  end
end
