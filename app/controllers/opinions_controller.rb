class OpinionsController < ApplicationController
  before_action :fetch_current_band
  before_action :fetch_current_opinion, only: [:edit, :update, :destroy]
  before_action :check_user_is_author, only: [:edit, :update, :destroy]
  before_action :check_user_has_not_written_opinion, only: [:new, :create]

  def index
    @reaction = Reaction.new
  end

  def new
    @opinion = Opinion.new
  end

  def create
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
  end

  def update
    if @opinion.update(opinion_params)
      redirect_to band_opinions_path(@band)
    else
      render 'edit'
    end
  end

  def destroy
    @opinion.reactions.each { |reaction| reaction.destroy }
    @opinion.destroy
    redirect_to band_opinions_path(@band)
  end

  protected

  def fetch_current_band
    @band = Band.find(params[:band_id])
  end

  def fetch_current_opinion
    @opinion = Opinion.find(params[:id])
  end

  def check_user_is_author
    @opinion = Opinion.find(params[:id])
    if current_user.id != @opinion.user_id
      flash[:alert] = "Access denied, you are not author of this opinion."
      redirect_to band_opinions_path(@opinion.band)
    end
  end

  def check_user_has_not_written_opinion
    @band = Band.find(params[:band_id])
    if current_user.opinions.select{ |opinion| opinion.band_id == @band.id }.count > 0
      flash[:alert] = "You have already written opinion on this band, you can't write another one."
      redirect_to band_opinions_path(@band)
    end
  end

  def opinion_params
    params.require(:opinion).permit(:text)
  end
end
