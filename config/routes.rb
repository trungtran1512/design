Rails.application.routes.draw do
  root 'home_pages#index'
  get 'home_pages/index'
  devise_for :users

  resources :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/dashboard' => "dashboard#index", as: :dashboard

  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
end
