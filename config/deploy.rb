set :application, "townent"
server 'photo-mast.remote', :app, :web, :db

set :user, 'deploy'
set :use_sudo, false
set :deploy_to, "/home/deploy/servers/townent"

require 'bundler/capistrano'
require 'rvm/capistrano'
require 'capistrano-unicorn'
require 'delayed/recipes'

load 'deploy/assets'

set :rvm_path, "/home/deploy/.rvm"
set :rvm_ruby_string, 'ruby-1.9.3-p327@global'
set :rvm_type, :user

set :scm, :git
set :shared_children, %w(log tmp/pids tmp/sock)
set :repository, "git@github.com:WizeFlux/townent.git"

set :branch, 'stable'
set :rails_env, 'production'
set :unicorn_env, rails_env

set :delayed_job_args, "-n 1"



before 'deploy', 'unicorn:stop'
before 'deploy', 'delayed_job:stop'

after 'deply', 'delayed_job:start'