class BlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :recent_blogs]
  # def index
  #   @user = User.find(params[:user_id])
  #   @blogs = @user.blogs
  # end

  def show
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:id])
    @article = @blog.articles.order('created_at DESC').first
  end

  def new
    @user = User.find(params[:user_id])
    @blog = @user.blogs.new
  end

  def edit
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @blog = @user.blogs.new(blog_params)
    if @blog.save
      redirect_to user_blog_path(@user, @blog)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:id])

    if @blog.update(blog_params)
      redirect_to user_blog_path(@user, @blog)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:id])
    @blog.destroy

    redirect_to root_path
  end

  def recent_blogs
    @blogs = Blog.all
    render 'recent_blogs'
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :subtitle)
    end
end
