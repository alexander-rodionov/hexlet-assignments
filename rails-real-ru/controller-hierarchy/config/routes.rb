# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    resources :movies do
      # BEGIN
      scope module: :movies do
        get :reviews, to: 'reviews#index_movie'
        get :comments, to: 'comments#index_movie'

        resource :reviews, only: :create
        resource :comments, only: :create

        resource :review
        resource :comment
      end
      # END
    end

    resources :reviews, only: %i[index]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

# +edit_movie_comment_path(resource_movie, comment)
# +edit_movie_path(movie)
# +edit_movie_review_path(resource_movie, review)
# +movie_comment_path(resource_movie, comment)
#   movie_comments_path(@movie)
# +movie_path(@movie)
# +movie_review_path(resource_movie, review)
#   movie_reviews_path(@movie)
# +movies_path
# +new_movie_comment_path
# +new_movie_path
# +new_movie_review_path
# reviews_path
# root_path
