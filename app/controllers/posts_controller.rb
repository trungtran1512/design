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
      @creator_name.map! { |name| name.present? ? name : "Author_Admin" }
      url_pages = doc.search("#hnmain .athing //td[@class='title']:last-child //a[@href]").map { |link| link["href"] }
      @link_pages = url_pages.select! { |i| i[/^https?:\/\/[\S]+/] }
      @arr_news = []
      @link_pages.each do |link|
        if link.present?
          hacker_news = {}
          begin
            obj = LinkThumbnailer.generate(link, attributes: [:images, :description], image_limit: 1, image_stats: false)
            hacker_news[:description] = obj.description
            if url_exist?(obj.images.first.src.to_s) == false
              obj.images.shift
              hacker_news[:image] = Post::DEFAULT_IMAGE if obj.images.size == 1
            else
              hacker_news[:image] = obj.images.first.src.to_s
            end
            @arr_news << hacker_news
          rescue => e
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

  def url_exist?(url_string)
    url = URI.parse(url_string)
    req = Net::HTTP.new(url.host, url.port)
    req.use_ssl = (url.scheme == 'https')
    path = url.path if url.path.present?
    res = req.request_head(path || '/')
    res.code != "404"
  rescue Errno::ENOENT
    false
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
