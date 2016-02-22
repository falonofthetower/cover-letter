class ReasonsController < ApplicationController
  def index
    @reasons = Reason.order(:weight)
  end
end
