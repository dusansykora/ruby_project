class CommentsController < ApplicationController  
  def new
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end
  
  def create
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:post_id])
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
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end
  
  def update
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    
    if @comment.update(comment_params)
      redirect_to band_post_path(@band, @post, anchor: 'comments')
    else
      render 'edit'
    end    
  end
  
  def destroy
    @band = Band.find(params[:band_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to band_post_path(@band, @post, anchor: 'comments')
  end
  
  protected
  
  def comment_params
    params.require(:comment).permit(:text, :represents_band)
  end
end
