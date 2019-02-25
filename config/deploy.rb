# config valid only for current version of Capistrano
lock "3.11.0"

set :application, "design"
set :repo_url, "git@github.com:trungpro152224/design.git"
set :branch, :develop
set :deploy_to, '/deploy/apps/design'
set :pty, true
set :linked_files, %w(config/database.yml config/application.yml)
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads)
set :keep_releases, 5
set :rvm_type, :user
set :rvm_ruby_version, 'ruby-2.5.3'

set :puma_rackup, -> {File.join(current_path, "config.ru")}
set :puma_state, -> {"#{shared_path}/tmp/pids/puma.state"}
set :puma_pid, -> {"#{shared_path}/tmp/pids/puma.pid"}
set :puma_bind, -> {"unix://#{shared_path}/tmp/sockets/puma.sock"}
set :puma_conf, -> {"#{shared_path}/puma.rb"}
set :puma_access_log, -> {"#{shared_path}/log/puma_access.log"}
set :puma_error_log, -> {"#{shared_path}/log/puma_error.log"}
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, "production"))
set :puma_threads, [0, 8]
set :puma_workers, 0
set :puma_worker_timeout, nil
set :puma_init_active_record, true
set :puma_preload_app, false

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :seed do
    on primary fetch(:migration_role) do
      within release_path do
        with rack_env: fetch(:rails_env, "production")  do
          execute :rake, 'db:seed'
        end
      end
    end
  end

  task :reset do
    on primary fetch(:migration_role) do
      within release_path do
        with rack_env: fetch(:rails_env, "production")  do
          execute :rake, 'db:reset DISABLE_DATABASE_ENVIRONMENT_CHECK=1'
        end
      end
    end
  end
  after 'deploy:migrate', 'deploy:reset', 'deploy:seed'
end