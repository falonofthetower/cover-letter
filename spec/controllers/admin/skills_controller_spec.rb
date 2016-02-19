require 'rails_helper'

describe Admin::SkillsController do
  describe "GET new" do
    it_behaves_like "requires admin" do
      let(:action) { get :new}
    end

    it "sets @skills" do
      sign_in
      get :new
      expect(assigns(:skill)).to be_instance_of(Skill)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        sign_in
        post :create, skill: {
          title: Faker::Lorem.word,
          text: Faker::Lorem.sentence
        }
      end

      it "redirects to the new_skills_path" do
        expect(response).to redirect_to skills_path
      end

      it "creates a new skill" do
        expect(Skill.count).to eq(1)
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before do
        sign_in
        post :create, skill: {
          text: Faker::Lorem.sentence(3)
        }
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "does not create a new skill" do
        expect(Skill.count).to eq(0)
      end

      it "sets the flash danger message" do
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "GET edit" do
    before do
      sign_in
    end

    it "renders the edit page" do
      skill = Fabricate(:skill)
      get :edit, id: skill.id

      expect(response).to render_template :edit
    end
  end

  describe "PATCH update" do
    context "with invalid info" do
      let(:skill) { Fabricate(:skill, title: "A Good Title", text: Faker::Lorem.sentence(5) )}
      before do
        sign_in
        put :update, { id: skill, skill: Fabricate.attributes_for(:skill, title: nil) }
      end

      it "renders the edit template" do
        expect(response).to render_template :edit
      end

      it "does not save the changes" do
        skill.reload
        expect(skill.title).to eq("A Good Title")
      end
    end

    context "with valid inputs" do
      let(:skill) { Fabricate(:skill, title: "Change Me", text: Faker::Lorem.sentence(5) )}

      before do
        sign_in
        put :update, { id: skill, skill: Fabricate.attributes_for(:skill, title: "Changed!") }
      end

      it "redirects to the index page" do
        expect(response).to redirect_to skills_path
      end

      it "it saves the changes to the skill" do
        skill.reload
        expect(skill.title).to eq("Changed!")
      end
    end
  end

  describe "DELETE destroy" do
    let(:skill) { Fabricate(:skill) }

    before do
      sign_in
    end

    it "redirects to the index" do
      delete :destroy, { id: skill.id }
      expect(response).to redirect_to skills_path
    end

    it "shows the flash message" do
      delete :destroy, { id: skill.id }
      expect(flash[:danger]).to be_present
    end

    it "destroys the skill" do
      expect { delete :destroy, { id: skill.id.to_param }}.to change(Skill, :count).by(0)
    end
  end
end
