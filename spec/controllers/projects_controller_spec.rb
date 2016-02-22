require 'rails_helper'

RSpec.describe ProjectsController do
  describe "GET index" do
    it "sets @projects" do
      project = Fabricate(:project)
      get :index
      expect(assigns(:projects)).to eq([project])
    end

    it "weights @projects according to weight" do
      project_2 = Fabricate(:project, weight: 2)
      project_3 = Fabricate(:project, weight: 3)
      project_1 = Fabricate(:project, weight: 1)
      get :index
      expect(assigns(:projects)).to eq([project_1, project_2, project_3])
    end
  end
end
