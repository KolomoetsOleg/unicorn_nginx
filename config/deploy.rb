#require 'bundler/capistrano'  # Add Bundler integration
require 'capistrano/ext/multistage'
require 'rvm/capistrano' # This is for working with capistrano

set :application, "unicorn_nginx"
set :rails_env, "production"
set :stages, %w(staging production)
set :default_stage, 'production'

set :use_sudo, false
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :rvm_ruby_string, 'ree'

set :scm, :git
set :repository, "git@github.com:KolomoetsOleg/unicorn_nginx.git"
set :branch, "master"
set :deploy_via, :remote_cache

before 'deploy:setup', 'rvm:install_rvm', 'rvm:install_ruby'

after 'deply:update_code', :roles => :app do
  run "rm -f #{current_release}/config/database.yml"
  run "ln -s #{deploy_to}/shared/config/database.yml #{current_release}/config/database.yml"
end  

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 'cat #{unicorn_pid}';
     else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi]"
  end  

  task :start do 
    run "bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end

  task :stop do
    run "if [ -f #{unicorn_pid}] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT 'cat #{unicorn_pid}'; fi"
  end
end  