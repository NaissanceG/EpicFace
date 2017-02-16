class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def show

  end

  def new
    @post = Post.new
  end

  def edit

  end

  def create
    @post = Post.new(post_params)
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
end
