Rails.application.routes.draw do
  root 'home#top'
  get 'home/about', to: 'home#about'
  resources :books
  devise_for :users
  resources :users
end
