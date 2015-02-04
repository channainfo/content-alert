class AlertsController < ApplicationController

  def index
    @alerts = Alert.order('created_at DESC').page(params[:page])
  end

  def new
    @alert = Alert.new
  end

  def create
    @alert = Alert.new(filter_params)

    if(@alert.save)
      redirect_to edit_alert_path(@alert), notice: 'Alert has been created'
    else
      flash.now[:alert] = 'Failed to create alert'
      render :new
    end
  end

  def edit
    @alert = Alert.find(params[:id])
  end

  def update
    @alert = Alert.find(params[:id])
    if(@alert.update_attributes(filter_params))
      redirect_to alerts_path, notice: 'Alert has been updated'
    else
      flash.now[:alert] = 'Could not save the alert'
      render :edit
    end
  end

  def destroy
    @alert = Alert.find(params[:id])
    if @alert.destroy
      redirect_to alerts_path, notice: 'Alert has been deleted'
    else
      redirect_to alerts_path, notice: 'Could not delete the alert'
    end
  end

  private
  def filter_params
    params.require(:alert).permit(:name, :url, :interval, :interval_unit, :email_template, :sms_template, 
                                  alert_places_attributes: [:id, :place_id, :_destroy],)
  end

end