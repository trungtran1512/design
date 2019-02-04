Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'home_pages/index'
  mount Ckeditor::Engine => '/ckeditor'
	root 'home_pages#index'
	resources :posts
end
