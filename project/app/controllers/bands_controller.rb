class BandsController < ApplicationController
  before_action :fetch_current_band, only: [:show, :edit, :update, :destroy]
  before_action :check_user_is_member_of_band, only: [:edit, :update, :destroy]
  before_action :check_user_is_not_in_any_band, only: [:new, :create]
  before_action :fetch_genre_names, only: [:new, :create, :edit, :update]
  before_action :fetch_members_names, only: [:show]

  def index
    @bands = Band.all
  end

  def new
    @band = Band.new
  end

  def create
    @band = Band.new(band_params)
    @band.genre = Genre.find_by_name(params[:band][:genre])
    @band.users = [current_user]
    
    if @band.save
       # current_user.update(:band_id => @band.id)
       redirect_to @band
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @band.genre = Genre.find_by_name(params[:band][:genre])
    
    if @band.update(band_params)
      redirect_to @band
    else
      render 'edit'
    end
  end

  def destroy
    @band.users.each { |user| user.update(:band_id => nil) }
    
    # destroying of other associated items
    
    @band.destroy
    redirect_to bands_path
  end

  protected

  def fetch_current_band
    @band = Band.find(params[:id])
  end
  
  def fetch_genre_names
    @genre_names = []
    Genre.all.each do |genre|
      @genre_names << genre.name
    end
  end
  
  def fetch_members_names
    @members = ""
    @band.users.each do |user|
      @members << ", " if @members.length > 0
      @members << user.username
    end
  end
  
  def check_user_is_not_in_any_band
    if current_user.band != nil
      flash[:alert] = "You are already in a band, you can't create another one."
      redirect_to current_user.band
    end
  end
  
  def check_user_is_member_of_band
    @band = Band.find(params[:id])
    if @band.id != current_user.band_id
      flash[:alert] = "Access denied, you are not a member of this band."
      redirect_to @band
    end
  end

  def band_params
    params.require(:band).permit(:name, :establish_year, :cover_photo)
  end
end
