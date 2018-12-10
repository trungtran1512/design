Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  get 'home/index'
  mount Ckeditor::Engine => '/ckeditor'
	root 'home#index'
	get 'say/about'
	resources :posts
end
