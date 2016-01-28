class AlbumsController < ApplicationController
  before_action :fetch_current_band
  before_action :fetch_current_album, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @album = Album.new
  end

  def show
  end

  def create
    @album = Album.new(album_params)
    @album.band = @band

    if @album.save
      redirect_to band_album_path(@band, @album)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @album.update(album_params)
      redirect_to band_album_path(@band, @album)
    else
      render 'edit'
    end
  end

  def destroy
    @album.tracks.each { |track| track.destroy }
    @album.destroy
    redirect_to band_albums_path
  end

  protected

  def fetch_current_band
    @band = Band.find(params[:band_id])
  end

  def fetch_current_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:title, :release_date, :cover_photo)
  end
end
