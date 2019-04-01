Rails.application.routes.draw do
  root 'home_pages#index'
  get 'home_pages/index'
  get 'home_pages/show'
  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :users, except: [:update, :new, :destroy, :edit, :show]

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  get '/dashboard' => "dashboard#index", as: :dashboard

  resources :posts

  get '/news', to: 'posts#crawl_data', as: 'news'
  get '/detail', to: 'posts#detail_page', as: 'detail'

  resources :colors
end
