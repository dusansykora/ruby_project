class AttendancesController < ApplicationController
  before_action :fetch_current_event_and_band, only: [:index, :create, :destroy]

  def index
    @attendances = @event.attendances
  end

  def create
    @attendance = Attendance.new
    @attendance.user_id = current_user.id
    @attendance.event_id = params[:event_id]

    if !@attendance.save
      flash[:alert] = 'asdasd'
    end

    redirect_to band_event_path(@band, @event)
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy
    redirect_to band_event_path(@band, @event)
  end

  private

  def fetch_current_event_and_band
    @event = Event.find(params[:event_id])
    @band = Band.find(params[:band_id])
  end

end
