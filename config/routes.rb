Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
	get 'say/goodbye'
	get 'say/hello'
	root 'say#hello'
	get 'say/about'
	resources :posts
end
