require 'rails_helper'

describe Admin::HistoriesController do
  describe "GET new" do
    it_behaves_like "requires admin" do
      let(:action) { get :new}
    end

    it "sets @histories" do
      sign_in
      get :new
      expect(assigns(:history)).to be_instance_of(History)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        sign_in
        post :create, history: {
          subject: "logo.png",
          text: "This the merry text has thus been typed into our browser"
        }
      end

      it "redirects to the new history path" do
        expect(response).to redirect_to histories_path
      end

      it "creates a new history" do
        expect(History.count).to eq(1)
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before do
        sign_in
        post :create, history: {
          text: "This the merry text has thus been typed into our browser"
        }
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "does not create a new history" do
        expect(History.count).to eq(0)
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
      history = Fabricate(:history)
      get :edit, id: history.id

      expect(response).to render_template :edit
    end
  end

  describe "PATCH update" do
    context "with invalid info" do
      let(:history) { Fabricate(:history, subject: "portrait.png", text: Faker::Lorem.sentence(5) )}
      before do
        sign_in
        put :update, { id: history, history: Fabricate.attributes_for(:history, subject: nil) }
      end

      it "renders the edit template" do
        expect(response).to render_template :edit
      end

      it "does not save the changes" do
        history.reload
        expect(history.subject).to eq("portrait.png")
      end
    end

    context "with valid inputs" do
      let(:history) { Fabricate(:history, subject: "portrait.png", text: Faker::Lorem.sentence(5) )}

      before do
        sign_in
        put :update, { id: history, history: Fabricate.attributes_for(:history, subject: "changed.jpg") }
      end

      it "redirects to the index page" do
        expect(response).to redirect_to histories_path
      end

      it "it saves the changes to the projec" do
        history.reload
        expect(history.subject).to eq("changed.jpg")
      end
    end
  end

  describe "DELETE destroy" do
    let(:history) { Fabricate(:history) }

    before do
      sign_in
    end

    it "redirects to the index" do
      delete :destroy, { id: history.id }
      expect(response).to redirect_to histories_path
    end

    it "shows the flash message" do
      delete :destroy, { id: history.id }
      expect(flash[:danger]).to be_present
    end

    it "destroys the history" do
      expect { delete :destroy, { id: history.id.to_param }}.to change(History, :count).by(0)
    end
  end
end
