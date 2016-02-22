class HistoriesController < ApplicationController
  def index
    @histories = History.order(:weight)
  end
end
