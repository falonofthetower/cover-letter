require 'rails_helper'

RSpec.describe ProjectsController do
  describe "GET index" do
    it "sets @projects" do
      project = Fabricate(:project)
      get :index
      expect(assigns(:projects)).to eq([project])
    end
  end
end
