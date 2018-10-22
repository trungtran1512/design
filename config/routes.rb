Rails.application.routes.draw do
  get 'say/hello'
  get 'say/goodbye'
	root to: "say#hello"
end
