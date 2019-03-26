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
      doc = Nokogiri::HTML(open(url).read, nil, 'utf-8')
      @title_pages = doc.search("#hnmain .athing //td[@class='title']:last-child").map { |link| link.text }
      arr_creator = doc.search("#hnmain .subtext a:first-of-type").map { |link| link.text }
      @creator_name = arr_creator.values_at(* arr_creator.each_index.select { |i| i.even? })
      url_pages = doc.search("#hnmain .athing //td[@class='title']:last-child //a[@href]").map { |link| link["href"] }
      link_pages = url_pages.select! { |i| i[/^https?:\/\/[\S]+/] }
      @arr_news = []
      link_pages.each do |link|
        if link.present?
          hacker_news = {}
          begin
            obj = LinkThumbnailer.generate(link, attributes: [:images, :title, :description], image_limit: 1, image_stats: false)
            hacker_news[:title] = obj.title
            hacker_news[:description] = obj.description
            hacker_news[:image] = obj.images.first.src.to_s
            @arr_news << hacker_news
          rescue => e
            hacker_news[:title] = "Not find page"
            hacker_news[:image] = Post::DEFAULT_IMAGE
            @arr_news << hacker_news
          end
        end
      end
      @arr_news
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
