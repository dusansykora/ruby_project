class TracksController < ApplicationController
  before_action :fetch_current_band_and_album
  before_action :fetch_current_track, only: [:show, :edit, :update, :destroy]
  before_action :user_is_member_of_band, only: [:new, :create, :edit, :update, :destroy]

  def index
  end

  def new
    @track = Track.new
  end

  def show
  end

  def create
    @track = Track.new(track_params)
    @track.album = @album

    if @track.save
      redirect_to band_album_path(@band, @album)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @track.update(track_params)
      redirect_to band_album_path(@band, @album)
    else
      render 'edit'
    end
  end

  def destroy
    @track.destroy
    redirect_to band_album_path(@band, @album)
  end

  protected

  def fetch_current_band_and_album
    @band = Band.find(params[:band_id])
    @album = Album.find(params[:album_id])
  end

  def fetch_current_track
    @track = Track.find(params[:id])
  end
  
  def user_is_member_of_band
    @band = Band.find(params[:band_id])
    @album = Album.find(params[:album_id])
    if current_user.band_id != @band.id
      flash[:alert] = "Access denied, you are not member of this band."
      redirect_to band_album_path(@band, @album)
    end
  end

  def track_params
    params.require(:track).permit(:number, :title)
  end
end
