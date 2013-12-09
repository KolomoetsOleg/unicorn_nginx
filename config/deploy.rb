#require 'bundler/capistrano'  # Add Bundler integration
require 'capistrano/ext/multistage'
require 'rvm/capistrano' # This is for working with capistrano
require "bundler/capistrano"

set :rails_env, "production"
set :stages, %w(staging production)
set :default_stage, 'production'
set :deploy_to, "/var/www/#{application}"

set :keep_releases, 2

set :use_sudo, false
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/tmp/pids/unicorn.pid"



set :scm, :git
set :repository, "git@github.com:KolomoetsOleg/unicorn_nginx.git"
set :branch, "master"
set :deploy_via, :remote_cache    

# before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby'

require 'capistrano-unicorn'
after 'deploy', 'unicorn:start'
after 'deploy', 'unicorn:reload'    # app IS NOT preloaded
after 'deploy', 'unicorn:restart'   # app preloaded