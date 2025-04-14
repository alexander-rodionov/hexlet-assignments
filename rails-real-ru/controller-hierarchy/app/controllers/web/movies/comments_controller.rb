# frozen_string_literal: true

class Web::Movies::CommentsController < Web::Movies::ApplicationController
  def show; end

  def new
    @comment = Comment.new
  end

  def create
    body = params.require(:comment).permit(:body)[:body]
    Comment.create!(movie: resource_movie, body:)
    redirect_to movie_comments_url(resource_movie)
  end

  def index
    @comments = Comment.all
  end

  def index_movie
    @comments = Comment.where(movie_id: resource_movie).all
    render :index
  end

  def edit
    @comment = Comment.find(item_id)
  end

  def update
    comment = params.require(:comment).permit(:body)
    Comment.find(item_id).update!(comment)
    redirect_to movie_comments_url(resource_movie)
  end

  def destroy
    Comment.find(item_id).destroy!
    redirect_to movie_comments_url(resource_movie)
  end

  def item_id
    params.permit(%i[format])[:format]
  end
end
