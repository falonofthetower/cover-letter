require 'rails_helper'

RSpec.describe ProjectsController do
  describe "GET index" do
    it "sets @projects" do
      project = Fabricate(:project)
      get :index
      expect(assigns(:projects)).to eq([project])
    end
  end

  describe "GET new" do
    it "sets @projects" do
      get :new
      expect(assigns(:project)).to be_instance_of(Project)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        post :create, project: {
          image_path: "logo.png",
          text: "This the merry text has thus been typed into our browser"
        }
      end

      it "redirects to the new_projects_path" do
        expect(response).to redirect_to projects_path
      end

      it "creates a new project" do
        expect(Project.count).to eq(1)
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before do
        post :create, project: {
          text: "This the merry text has thus been typed into our browser"
        }
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "does not create a new project" do
        expect(Project.count).to eq(0)
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "GET edit" do
    it "renders the edit page" do
      project = Fabricate(:project)
      get :edit, id: project.id

      expect(response).to render_template :edit
    end
  end

  describe "PATCH update" do
    context "with invalid info" do
      let(:project) { Fabricate(:project, image_path: "portrait.png", text: Faker::Lorem.sentence(5) )}
      before do
        put :update, { id: project, project: Fabricate.attributes_for(:project, image_path: nil) }
      end

      it "renders the edit template" do
        expect(response).to render_template :edit
      end

      it "does not save the changes" do
        project.reload
        expect(project.image_path).to eq("portrait.png")
      end
    end

    context "with valid inputs" do
      let(:project) { Fabricate(:project, image_path: "portrait.png", text: Faker::Lorem.sentence(5) )}
      before do
        put :update, { id: project, project: Fabricate.attributes_for(:project, image_path: "changed.jpg") }
      end

      it "redirects to the index page" do
        expect(response).to redirect_to projects_path
      end

      it "it saves the changes to the projec" do
        project.reload
        expect(project.image_path).to eq("changed.jpg")
      end
    end
  end

  describe "DELETE destroy" do
    let(:project) { Fabricate(:project) }

    it "redirects to the index" do
      delete :destroy, { id: project.id }
      expect(response).to redirect_to projects_path
    end

    it "shows the flash message" do
      delete :destroy, { id: project.id }
      expect(flash[:danger]).to be_present
    end

    it "destroys the project" do
      expect { delete :destroy, { id: project.id.to_param }}.to change(Project, :count).by(0)
    end
  end
end
