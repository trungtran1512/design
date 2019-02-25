set :stage, :production
set :rails_env, :production
set :deploy_to, "/deploy/apps/design"
set :branch, :develop
server "54.202.119.0", user: "webdesign", roles: %w(web app db)