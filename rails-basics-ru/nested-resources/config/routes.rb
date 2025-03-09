# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'

  # BEGIN
  resources :posts do
    resources :post_comments, only: %i[create destroy edit update]
  end
  # END
end
