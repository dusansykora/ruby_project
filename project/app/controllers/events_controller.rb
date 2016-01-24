class EventsController < ApplicationController
  before_action :fetch_current_event, only: [:show, :edit, :update, :destroy]
  before_action :fetch_current_band, only: [:new, :create]

  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.band = @band

    if @event.save
       redirect_to band_event_path(@band, @event)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    if @event.update(event_params)
      redirect_to @event
    else
      render 'edit'
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private

  def fetch_current_event
    @event = Event.find(params[:id])
  end

  def fetch_current_band
    @band = Band.find(params[:band_id])
  end

  def event_params
    params.require(:event).permit(:title, :start_time, :duration, :place, :info)
  end
end