class ReactionsController < ApplicationController
  def create
    @band = Band.find(params[:band_id])
    @reaction = Reaction.new(reaction_params)
    @reaction.user_id = current_user.id
    if params[:reaction][:positive] == '0'
      @reaction.positive = false
    else
      @reaction.positive = true
    end
    
    if !@reaction.save
      flash[:alert] = 'Error while processing reaction on opinion.'      
    end
    redirect_to band_opinions_path(@band)
  end
  
  protected
  
  def reaction_params
    params.require(:reaction).permit(:opinion_id)
  end
end
