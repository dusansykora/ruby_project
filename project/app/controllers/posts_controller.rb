class PostsController < ApplicationController
  before_action :fetch_current_band
  before_action :fetch_current_post, only: [:show, :edit, :update, :destroy]
  before_action :check_user_is_member_of_band, only: [:new, :create, :edit, :update, :destroy]
  
  def index
  end
  
  def show
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.band_id = @band.id
    
    if @post.save
      redirect_to band_post_path(@band, @post)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @post.update(post_params)
      redirect_to band_post_path(@band, @post)
    else
      render 'edit'
    end    
  end
  
  def destroy
    @post.comments.each { |comment| comment.destroy }
    @post.destroy
    redirect_to band_posts_path(@band)
  end
  
  protected
  
  def fetch_current_band
    @band = Band.find(params[:band_id])
  end
  
  def fetch_current_post
    @post = Post.find(params[:id])
  end
  
  def check_user_is_member_of_band
    @band = Band.find(params[:band_id])
    if current_user.band_id != @band.id
      flash[:alert] = "Access denied, you are not member of this band."
      redirect_to band_posts_path(@band)
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
