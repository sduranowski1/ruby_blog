class ArticlesController < ApplicationController
  def index
    @articles = Article.all
    @posts = Post.limit(6).order(created_at: :desc)  # Adjust `Post` to match your model name
  end

  def show
    @article = Article.find(params[:id])
  end
end
