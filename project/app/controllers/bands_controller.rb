class BandsController < ApplicationController

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create

  end

  def show

  end

  def update
  end

  def delete
  end

  private

  def fetch_current_band
    @band = Band.find(params[:id])
  end

  def band_params
    params.require(:band).permit(:name, :establish_year)
  end
end
