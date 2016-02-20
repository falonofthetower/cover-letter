require 'rails_helper'

RSpec.describe ReasonsController do
  describe "GET index" do
    it "sets @reasons" do
      reason = Fabricate(:reason)
      get :index
      expect(assigns(:reasons)).to eq([reason])
    end
  end
end
