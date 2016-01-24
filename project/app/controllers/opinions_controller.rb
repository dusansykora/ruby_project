class OpinionsController < ApplicationController
  def new
    @band = Band.find(params[:band_id])
    @opinion = Opinion.new
  end

  def create
    @band = Band.find(params[:band_id])
    @opinion = Opinion.new(opinion_params)
    if @opinion.save
       redirect_to @opinion.band
    else
      render 'new'
    end
  end

  def edit    
    @band = Band.find(params[:band_id])
    @opinion = Opinion.find(params[:id])
  end

  def update
    @band = Band.find(params[:band_id])
    @opinion = Opinion.find(params[:id])
    if @opinion.update(opinion_params)
      redirect_to @opinion.band
    else
      render 'edit'
    end
  end

  def destroy
    @band = Band.find(params[:band_id])
    @opinion = Opinion.find(params[:id])
    @opinion.destroy
    redirect_to @band
  end
  
  protected

  def opinion_params
    params.require(:opinion).permit(:user_id, :band_id, :text)
  end
end
