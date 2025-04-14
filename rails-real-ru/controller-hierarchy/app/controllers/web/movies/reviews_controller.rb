# frozen_string_literal: true

class Web::Movies::ReviewsController < Web::Movies::ApplicationController
  def show; end

  def new
    @review = Review.new
  end

  def create
    body = params.require(:review).permit(:body)[:body]
    Review.create!(movie: resource_movie, body:)
    redirect_to movie_reviews_url(resource_movie)
  end

  def edit
    @review = Review.find(item_id)
  end

  def index
    @reviews = Review.where(movie_id: resource_movie).all
    render :index
  end

  def index_movie
    @reviews = Review.all
    render :index, locals: { resource_movie: Movie.first }
  end

  def update
    review = params.require(:review).permit(:body)
    Review.find(item_id).update!(review)
    redirect_to movie_reviews_url(resource_movie)
  end

  def destroy
    Review.find(item_id).destroy!
    redirect_to movie_reviews_url(resource_movie)
  end

  def item_id
    params.permit(%i[format])[:format]
  end
end
