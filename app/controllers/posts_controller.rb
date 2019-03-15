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

  def crawl_data
    if current_user.admin?
      url = Post::URL_DATA
      doc = Nokogiri::HTML(open(url))
      @titles = doc.search('.article-title').map(&:text).first(7)
      @descriptions = doc.search('.article-summary').map(&:text).first(7)
      @details = doc.search('.article-meta').map(&:text).first(7)
      @images = doc.search('img').first(7)
      @urls = doc.search("article .article-thumbnail a").map {|link| link['href']}.first(7)
    else
      redirect_to users_path
    end
  end

  def detail_site
    if params[:url].present?
      site = Nokogiri::HTML(open("#{Post::URL_DATA}/#{params[:url]}"))
      header = site.search(".the-article-header h1").text
      meta = site.search(".the-article-meta li").text.first(16)
      title = site.search(".the-article-summary").text
      body = site.search(".the-article-body").text
      img = site.search(".picture img").attr('src').value if site.search(".picture img").present?
      @result = {
        'header': header,
        'meta': meta,
        'title': title,
        'body': body,
        'img': img
      }
    else
      redirect_to web_crawler_url
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
