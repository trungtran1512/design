set :stage, :production
set :rails_env, :production
set :deploy_to, "/deploy/apps/design"
set :branch, :develop
server "54.244.57.100", user: "webdesign", roles: %w(web app db)