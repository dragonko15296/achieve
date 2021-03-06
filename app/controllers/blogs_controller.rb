class BlogsController < ApplicationController
  before_action :set_blog, only: [:edit,:update,:destroy]
  before_action :authenticate_user!
  
  def index
    @blogs = Blog.all
    @users = User.all
  end
  def new
    if params[:back]
      @blog = Blog.new(blogs_params)
    else
      @blog = Blog.new
    end
  end
  def create
    @blog = Blog.new(blogs_params)
    @blog.user_id = current_user.id
    if @blog.save
      redirect_to blogs_path, notice: '記事を投稿しました！'
      NoticeMailer.sendmail_blog(@blog).deliver
    else
      render action: 'new'
    end
  end
  def edit
  end
  def update
    @blog.update(blogs_params)
    redirect_to blogs_path, notice: ' 記事を更新しました！'
  end
  def destroy
    @blog.destroy
    redirect_to blogs_path, notice: '記事を削除しました！'
  end
  def confirm
    @blog = Blog.new(blogs_params)
    render :new if @blog.invalid?
  end

  private
    def blogs_params
      params.require(:blog).permit(:title,:content)
    end
    def set_blog
      @blog = Blog.find(params[:id])
    end
end