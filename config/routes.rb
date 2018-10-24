Rails.application.routes.draw do
	get 'say/goodbye'
	get 'say/hello'
	root 'say#hello'
	get 'say/about'
end
