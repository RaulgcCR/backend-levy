Rails.application.routes.draw do
  get 'main/index'

  resources :comments
  resources :scores
  devise_for :admins
  resources :users
  resources :stores
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'
end
