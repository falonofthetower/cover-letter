require 'rails_helper'

RSpec.describe SessionsController do
  describe "GET new" do
    it "gets the new template" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    context "with valid password" do
      before do
        post :create, password: ENV["SECRET"]
      end

      it "redirects to the home_path" do
        expect(response).to redirect_to root_path
      end

      it "it sets the session as logged in" do
        expect(session[:admin]).to be_truthy
      end
    end

    context "with invalid password" do
      before do
        post :create, password: "OOPS"
      end

      it "it should render the template again" do
        expect(response).to render_template :new
      end

      it "it should show a danger message" do
        expect(flash[:danger]).to be_present
      end

      it "admin should not be true" do
        expect(session[:admin]).not_to be_truthy
      end
    end
  end

  describe "GET destroy" do
    before do
      session[:admin] = true
      get :destroy
    end

    it "should set session[:admin] to nil" do
      session[:admin] = true
      get :destroy
      expect(session[:admin]).not_to be_truthy
    end
  end
end
