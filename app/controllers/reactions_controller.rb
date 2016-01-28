class ReactionsController < ApplicationController
  before_action :fetch_current_band_and_opinion, only: [:create]
  before_action :check_user_has_not_done_reaction, only: [:create]
  
  def create
    @reaction = Reaction.new
    @reaction.user_id = current_user.id
    @reaction.opinion_id = @opinion.id
    
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
  
  def fetch_current_band_and_opinion
    @band = Band.find(params[:band_id])
    @opinion = Opinion.find(params[:opinion_id])
  end
  
  def check_user_has_not_done_reaction
    @opinion = Opinion.find(params[:opinion_id])
    if current_user.reactions.select{ |reaction| reaction.opinion_id == @opinion.id }.count > 0
      flash[:alert] = "You have already reacted on this opinion."
      redirect_to band_opinions_path(@opinion.band)
    end
  end
end
