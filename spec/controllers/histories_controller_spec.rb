require 'rails_helper'

RSpec.describe HistoriesController do
  describe "GET index" do
    it "sets @histories" do
      history = Fabricate(:history)
      get :index
      expect(assigns(:histories)).to eq([history])
    end
  end
end
