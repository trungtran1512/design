Rails.application.routes.draw do
  root 'home_pages#index'
  get 'home_pages/index'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, except: [:update, :new, :destroy, :edit, :show]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/dashboard' => "dashboard#index", as: :dashboard

  resources :posts

  resources :colors
end
