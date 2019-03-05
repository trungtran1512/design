class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
	before_action :find_post, only: [:edit, :update, :show, :delete]
  before_action :post_owner, only: [:edit, :update, :destroy]

  def index
    @q = Post.ransack(params[:q])
    if @q.present?
      @posts = @q.result(distinct: true).published.sort_time.page(params[:page]).per(12)
    else
      @posts = Post.published.sort_time.page(params[:page]).per(12)
    end
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:notice] = "Successfully created post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error creating new post!"
      render :new
    end
  end

  def edit
  end

  def show
  	@post = Post.find(params[:id])
  end

  def update
    if @post.update_attributes(post_params)
      flash[:notice] = "Successfully updated post!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Error updating post!"
      render :edit
    end
  end

  def destroy
  	if @post.destroy
  		flash[:notice] = "Successfully deleted post!"
  		redirect_to users_path
  	else
  		flash[:alert] = "Error deleting post!"
  	end
  end

  def post_owner
    @post = Post.find_by_id(params[:id])
    unless @post.user_id == current_user.id
      flash[:notice] = 'Access denied as you are not owner of this Post'
      redirect_to root_path
    end
  end

  private

  def post_params
  	params.require(:post).permit(:title, :discription, :image, :published)
  end

  def find_post
  	@post = Post.find(params[:id])
  end
end
