#require 'bundler/capistrano'  # Add Bundler integration
require 'capistrano/ext/multistage'
require 'rvm/capistrano' # This is for working with capistrano


set :application, "unicorn_nginx"
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

require "bundler/capistrano"

set :bundle_flags, ''
set :bundle_without, %w{development test}.join(' ')


after 'deploy', 'deploy:create_sock'

namespace 'bundle' do
  task 'install' do 
   run "cd #{release_path} && bundle install --gemfile #{release_path}/Gemfile --path #{shared_path}/bundle  --without development test"
  end
end

namespace 'deploy' do
  task 'create_sock' do
    run "mkdir #{current_path}/tmp/sockets"
  end
end


# before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby'
require 'capistrano-unicorn'
before 'deploy', 'unicorn:stop'
after 'deploy', 'unicorn:start'

namespace 'unicorn' do
  task 'stop' do
    run "cd #{current_path}; ps aux | grep 'unicorn' | awk '{print $2}' | xargs kill -9 ;"
  end
end
