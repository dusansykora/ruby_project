class OpinionsController < ApplicationController
  def index
    @band = Band.find(params[:band_id])
    @reaction = Reaction.new
  end
  
  def new
    @band = Band.find(params[:band_id])
    @opinion = Opinion.new
  end

  def create
    @band = Band.find(params[:band_id])
    @opinion = Opinion.new(opinion_params)
    @opinion.user_id = current_user.id
    @opinion.band_id = @band.id
    
    if @opinion.save
       redirect_to band_opinions_path(@band)
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
      redirect_to band_opinions_path(@band)
    else
      render 'edit'
    end
  end

  def destroy
    @band = Band.find(params[:band_id])
    @opinion = Opinion.find(params[:id])
    @opinion.reactions.each { |reaction| reaction.destroy }
    @opinion.destroy
    redirect_to @band
  end
  
  protected

  def opinion_params
    params.require(:opinion).permit(:text)
  end
end
