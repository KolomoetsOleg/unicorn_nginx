set :user, "ubuntu"
server "ec2-54-200-229-20.us-west-2.compute.amazonaws.com", :app, :web, :db, :primary => true
set :deploy_to, '/home/ubuntu/unicorn_nginx'