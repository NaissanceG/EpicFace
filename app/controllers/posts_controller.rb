class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :owned_post, only: [:edit, :update, :destroy]
  
  def index
    @posts = Post.all
  end

  def show

  end

  def new
    @post = current_user.posts.build
  end

  def edit

  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Your post is added!"
      redirect_to posts_path
    else
      flash[:alert] = "Oops, something went wrong. Please try again."
      render :new
    end
  end

  def update
    if @post.update(post_params)
      flash[:success] = "Post updated."
      redirect_to post_path(@post)
    else
      flash[:alert] = "Update failed. Please try again."
      render :edit
    end
  end

  def destroy

    @post.destroy
    flash[:notice] = "Your post was deleted!"
    redirect_to posts_path
  end

private
  def post_params
    params.require(:post).permit(:caption, :image)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def owned_post
    unless current_user == @post.user
      flash[:alert] = "Oops, you got the wrong post.. you can only access your own posts. Try again."
      redirect_to root_path
    end
  end

end
