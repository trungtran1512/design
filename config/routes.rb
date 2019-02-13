Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/dashboard' => "dashboard#index", as: :dashboard
  get 'home_pages/index'
  mount Ckeditor::Engine => '/ckeditor'
  root 'home_pages#index'
  resources :posts
end
