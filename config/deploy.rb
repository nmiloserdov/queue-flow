# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'queue_flow'

set :repo_url, 'git@github.com:nmiloserdov/queue-flow.git'

set :deploy_to, '/home/deployer/queue_flow'
set :deploy_user, 'deployer'

set :linked_files, %w(config/database.yml config/private_pub.yml .env config/private_pub_thin.yml)

set :linked_dirs,  %w(log tmp/pids tmp/cache tmp/sockets public/system public/uploads)

set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      # execute :touch, release_path.join('tmp/restart')
      invoke 'unicorn:restart'
    end
  end

  after :publishing, :restart
end

namespace :private_pub do
  desc 'Start private_pub server'
  task :start do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec thin -C config/private_pub_thin.yml start"
        end
      end
    end
  end
  desc 'Stop private_pub server'
  task :stop do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec thin -C config/private_pub_thin.yml stop"
        end
      end
    end
  end
  desc 'Restart private_pub server'
  task :restart do
    on roles(:app) do
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :bundle, "exec thin -C config/private_pub_thin.yml restart"
        end
      end
    end
  end
end

after 'deploy:finished', 'private_pub:restart'
after 'deploy:finished', 'thinking_sphinx:index'
after 'deploy:finished', 'thinking_sphinx:restart'
