require 'rails_helper'

describe Admin::ReasonsController do
  describe "GET new" do
    it_behaves_like "requires admin" do
      let(:action) { get :new}
    end

    it "sets @reasons" do
      sign_in
      get :new
      expect(assigns(:reason)).to be_instance_of(Reason)
    end
  end

  describe "POST create" do
    context "with valid inputs" do
      before do
        sign_in
        post :create, reason: {
          header: "King of Everything",
          text: "I dominate every single task like a ninja!"
        }
      end

      it "redirects to the new_reasons_path" do
        expect(response).to redirect_to reasons_path
      end

      it "creates a new reason" do
        expect(Reason.count).to eq(1)
      end

      it "sets the flash success message" do
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid inputs" do
      before do
        sign_in
        post :create, reason: {
          text: "I am short and ugly while wearing socks with sandals"
        }
      end

      it "renders the new template" do
        expect(response).to render_template :new
      end

      it "does not create a new reason" do
        expect(Reason.count).to eq(0)
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
      reason = Fabricate(:reason)
      get :edit, id: reason.id

      expect(response).to render_template :edit
    end
  end

  describe "PATCH update" do
    context "with invalid info" do
      let(:reason) { Fabricate(:reason, header: "Viking Warrior", text: Faker::Lorem.sentence(5) )}
      before do
        sign_in
        put :update, { id: reason, reason: Fabricate.attributes_for(:reason, header: nil) }
      end

      it "renders the edit template" do
        expect(response).to render_template :edit
      end

      it "does not save the changes" do
        reason.reload
        expect(reason.header).to eq("Viking Warrior")
      end
    end

    context "with valid inputs" do
      let(:reason) { Fabricate(:reason, header: "Ruby Monk", text: Faker::Lorem.sentence(5) )}

      before do
        sign_in
        put :update, { id: reason, reason: Fabricate.attributes_for(:reason, header: "Ruby Guru") }
      end

      it "redirects to the index page" do
        expect(response).to redirect_to reasons_path
      end

      it "it saves the changes to the projec" do
        reason.reload
        expect(reason.header).to eq("Ruby Guru")
      end
    end
  end

  describe "DELETE destroy" do
    let(:reason) { Fabricate(:reason) }

    before do
      sign_in
    end

    it "redirects to the index" do
      delete :destroy, { id: reason.id }
      expect(response).to redirect_to reasons_path
    end

    it "shows the flash message" do
      delete :destroy, { id: reason.id }
      expect(flash[:danger]).to be_present
    end

    it "destroys the reason" do
      expect { delete :destroy, { id: reason.id.to_param }}.to change(Reason, :count).by(0)
    end
  end
end
