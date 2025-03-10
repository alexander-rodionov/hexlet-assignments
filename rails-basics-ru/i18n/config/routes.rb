# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN

  root 'home#index'
  resources :home, only: %i[index]

  scope '/(:locale)', locale: /en|ru/ do
    resources :posts do
      resources :comments, controller: 'posts/comments' # , only: %i[create update edit], controller: 'posts/comments'
    end

    # namespace :posts do
    #   resources :comments, except: %i[create update edit]
    # end
  end
  # END

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
