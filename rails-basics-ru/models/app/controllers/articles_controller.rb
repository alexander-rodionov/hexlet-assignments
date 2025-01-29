class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    p 'show method', params
    @article = Article.find_by(id: params[:id])
    @not_found = @article.nil?
  end
end
