# config valid only for current version of Capistrano
lock "3.10.1"

set :application, 'yuanda'
set :repo_url, 'git@github.com:big-bing/yuanda.git'

set :user,            'deploy'
set :deploy_to, '/rails_apps/yuanda'

set :rbenv_type, :user
set :rbenv_ruby, '2.4.1'
set :rbenv_roles, :all

set :format, :pretty
set :log_level, :debug
set :pty, false
set :keep_releases, 5

set :linked_files, fetch(:linked_files, []).push('config/application.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/assets')

set :puma_state,      "#{ shared_path }/tmp/pids/puma.state"
set :puma_pid,        "#{ shared_path }/tmp/pids/puma.pid"
set :puma_access_log, "#{ release_path }/log/puma.error.log"
set :puma_error_log,  "#{ release_path }/log/puma.access.log"
set :puma_preload_app, true
set :puma_worker_timeout, nil
# set :sidekiq_config, -> { File.join(shared_path, 'config', 'sidekiq.yml') }

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  after  :finishing,    :cleanup
  after  :restart, 'puma:restart'
end
