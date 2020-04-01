Rails.application.routes.draw do
  root 'home#top'
  get 'home/about', to: 'home#about'
  resources :users,only: [:show,:index,:edit,:update]
  resources :books
  devise_for :users

end
