class Admin::HistoriesController < AdminController
  def index
    @histories = History.all
    @admin = true
  end

  def new
    @history = History.new
  end

  def create
    @history = History.new(history_params)
    if @history.save
      flash[:success] = "Saved!"
      redirect_to histories_path
    else
      flash[:danger] = "Your submission has failed!"
      render :new
    end
  end

  def edit
    @history = History.find(params[:id])
  end

  def update
    @history = History.find(params[:id])
    if @history.update(history_params)
      redirect_to histories_path
      flash[:success] = "History Updated"
    else
      render :edit
    end
  end

  def destroy
    @history = History.find(params[:id])
    @history.destroy
    flash[:danger] = "Another one bites the dust!"
    redirect_to histories_path
  end

  private

  def history_params
    params.require(:history).permit(
      :subject,
      :text
    )
  end
end
