class BandsController < ApplicationController
  before_action :fetch_current_band, only: [:show, :edit, :update, :destroy]

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
    @genre_names = []
    Genre.all.each do |genre|
      @genre_names << genre.name
    end
  end

  def create
    @band = Band.new(band_params)

    if @band.save
       current_user.update(:band_id => @band.id)
       redirect_to @band
    else
      render 'new'
    end
  end

  def show
  end

  def update
  end

  def destroy
    @band.users.each { |user| user.update(:band_id => nil) }
    @band.destroy
    redirect_to bands_path
  end

  private

  def fetch_current_band
    @band = Band.find(params[:id])
  end

  def band_params
    params.require(:band).permit(:name, :establish_year, :genre)
  end
end
