# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'queue_flow'

set :repo_url, 'git@github.com:nmiloserdov/queue-flow.git'

set :deploy_to, '/home/deployer/queue_flow'
set :deploy_user, 'deployer'

set :linked_files, %w(config/database.yml config/private_pub.yml .env)
set :linked_dirs,  %w(bin log tmp/pids tmp/cache tmp/sockets public/system public/uploads)

set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart')
    end
  end

  # after :restart, :clear_cache do
  #   on roles(:web), in: :groups, limit: 3, wait: 10 do
  #     within release_path do
  #       execute :rake, 'cache:clear'
  #     end
  #   end
  # end

  after :publishing, :restart
end
