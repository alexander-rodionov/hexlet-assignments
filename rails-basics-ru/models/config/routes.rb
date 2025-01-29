# frozen_string_literal: true

Rails.application.routes.draw do
  resources :articles, only: [ :index, :show ] 
  root 'articles#index'
  get 'articles', to: 'articles#index', as: 'articles_index'
  # get 'articles/:id', to: 'articles#show', as: 'articles_show'
  get 'articles/show', to: 'articles#show', as: 'articles_show'
end
