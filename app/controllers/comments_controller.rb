class CommentsController < ApplicationController
  # http_basic_authenticate_with name: "Kiope", password: "secret", only: :destroy
    before_action :authenticate_user!, only: [:destroy]

  def create
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:blog_id])
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to user_blog_article_path(@user, @blog, @article)
  end

  def destroy
    @user = User.find(params[:user_id])
    @blog = @user.blogs.find(params[:blog_id])
    @article = @blog.articles.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to user_blog_article_path(@user, @blog, @article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
