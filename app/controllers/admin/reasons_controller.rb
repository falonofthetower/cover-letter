class Admin::ReasonsController < AdminController
  def index
    @reasons = Reason.all
  end

  def new
    @reason = Reason.new
  end

  def create
    @reason = Reason.new(reason_params)
    if @reason.save
      flash[:success] = "Saved!"
      redirect_to reasons_path
    else
      flash[:danger] = "Your submission has failed!"
      render :new
    end
  end

  def edit
    @reason = Reason.find(params[:id])
  end

  def update
    @reason = Reason.find(params[:id])
    if @reason.update(reason_params)
      redirect_to reasons_path
      flash[:success] = "Reason updated"
    else
      render :edit
    end
  end

  def destroy
    @reason = Reason.find(params[:id])
    @reason.destroy
    flash[:danger] = "Another one bites the dust!"
    redirect_to reasons_path
  end

  private

  def reason_params
    params.require(:reason).permit(
      :header,
      :text,
      :weight
    )
  end
end
