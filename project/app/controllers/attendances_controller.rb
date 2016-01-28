class AttendancesController < ApplicationController
  before_action :fetch_current_event_and_band, only: [:index, :create, :destroy]

  def index
    @attendants = []
    @event.attendances.each do |att|
      @attendants << User.find(att.user_id).email
    end
  end

  def create
    @attendance = Attendance.new
    @attendance.user_id = current_user.id
    @attendance.event_id = @event.id

    if !@attendance.save
      flash[:alert] = 'Error while saving attendance on this event.'
    end

    redirect_to band_event_path(@band, @event)
  end

  def destroy
    @attendance = Attendance.find(params[:id])
    @attendance.destroy
    redirect_to band_event_path(@band, @event)
  end

  protected

  def fetch_current_event_and_band
    @event = Event.find(params[:event_id])
    @band = Band.find(params[:band_id])
  end

end
