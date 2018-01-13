require 'capistrano-db-tasks'

set :target_access, 'root@120.79.183.52'

role :app, [ "#{ fetch(:target_access) }" ]
role :web, [ "#{ fetch(:target_access) }" ]
role :db,  [ "#{ fetch(:target_access) }" ]

set :stage, :master
set :branch, :master
set :log_level, :debug
set :puma_threads,    [4, 16]
set :puma_workers,    2

