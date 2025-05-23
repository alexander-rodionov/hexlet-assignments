# frozen_string_literal: true

class Web::ArticlesController < Web::ApplicationController
  def show
    @article = Rails.cache.fetch("article/#{params[:id]}", expires_in: 12.hours) do
      Article.find(params[:id])
    end
  end

  def index
    @articles = Article.all
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
