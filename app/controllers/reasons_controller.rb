class ReasonsController < ApplicationController
  def index
    @reasons = Reason.all
  end
end
