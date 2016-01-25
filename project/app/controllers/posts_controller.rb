class PostsController < ApplicationController
  def index
    @band = Band.find(params[:band_id])
  end
  
  def show
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:id])
  end
  
  def new
    @band = Band.find(params[:band_id])
    @post = Post.new
  end
  
  def create
    @band = Band.find(params[:band_id])
    @post = Post.new(post_params)
    @post.band_id = @band.id
    
    if @post.save
      redirect_to band_post_path(@band, @post)
    else
      render 'new'
    end
  end
  
  def edit
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:id])
  end
  
  def update
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:id])
    
    if @post.update(post_params)
      redirect_to band_post_path(@band, @post)
    else
      render 'edit'
    end    
  end
  
  def destroy
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to band_posts_path(@band)
  end
  
  protected
  
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
