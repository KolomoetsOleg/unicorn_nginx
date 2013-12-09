set :user, "ubuntu"
set :application, "unicorn_nginx"
server "ec2-54-200-108-21.us-west-2.compute.amazonaws.com", :app, :web, :db, :primary => true
set :ssh_options, { :forward_agent => true }
