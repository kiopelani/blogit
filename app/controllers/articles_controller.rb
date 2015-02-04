class ArticlesController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:blog_id])
    @article = Article.find(params[:id])
    @blog_articles = @blog.articles.order('created_at DESC')
    @article_index = @blog_articles.index(@article)
  end

  def new
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:blog_id])
    @article = @blog.articles.new
  end

  def edit
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:blog_id])
    @article = @blog.articles.find(params[:id])
  end

  def create
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:blog_id])
    @article = @blog.articles.new(article_params)
    if @article.save
      redirect_to user_blog_article_path(@user, @blog, @article)
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:blog_id])
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to user_blog_article_path(@user, @blog, @article)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:blog_id])
    @article = @blog.articles.find(params[:id])
    @article.destroy

    redirect_to user_blog_path(@user, @blog)
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
