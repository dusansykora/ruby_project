class CommentsController < ApplicationController
  before_action :fetch_current_band_and_post
  before_action :fetch_current_comment, only: [:edit, :update, :destroy]
  before_action :check_user_is_author, only: [:edit, :update, :destroy]
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(comment_params)
    @comment.post_id = @post.id
    @comment.user_id = current_user.id
    
    if @comment.save
      redirect_to band_post_path(@band, @post, anchor: 'comments')
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @comment.update(comment_params)
      redirect_to band_post_path(@band, @post, anchor: 'comments')
    else
      render 'edit'
    end    
  end
  
  def destroy
    @comment.destroy
    redirect_to band_post_path(@band, @post, anchor: 'comments')
  end
  
  protected
  
  def fetch_current_band_and_post
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:post_id])
  end
  
  def fetch_current_comment
    @comment = Comment.find(params[:id])
  end
  
  def check_user_is_author
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    
    if current_user.id != @comment.user_id
      flash[:alert] = "Access denied, you are not author of this comment."
      redirect_to band_post_path(@band, @post, anchor: 'comments')
    end
  end
  
  def comment_params
    params.require(:comment).permit(:text, :represents_band)
  end
end
