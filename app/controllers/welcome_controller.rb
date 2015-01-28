class WelcomeController < ApplicationController
  def index
    if current_user
      @user = current_user
      @user_blogs = @user.blogs
      render 'user_home'
    else
      render 'index'
    end
  end

end
