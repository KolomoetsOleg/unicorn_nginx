# deploy_to = "/home/ubuntu/unicorn_nginx" # dir for deploy
rails_root = "/Users/oleg/Documents/unicorn_nginx"#{deploy_to}/current" 

working_directory rails_root

# pid_file = "#{rails_root}/tmp/pids/unicorn.pid" # Save pid
pid "#{rails_root}/tmp/pids/unicorn.pid" # Save pid


socket_file = "#{rails_root}/tmp/sockets/unicorn.sock" # Save sockets


# log_file = "tmp/log/unicorn.log" # Save log
stdout_path "#{rails_root}/tmp/log/unicorn.stdout.log" # Save log

# err_log = "tmp/log/unicorn_error.log" #Save error log
stderr_path rails_root+"/tmp/log/unicorn.stderr.log" #Save error log

# old_pid = pid_file + '.oldbin' #Save old pid 
# old_pid = pid + '.oldbin' #Save old pid 


timeout 30
worker_processes 1 # You can change it depending on the load
# listen socket_file, :backlog => 1024
listen 
# pid pid_file
# stderr_path err_log
# stdout_path log_file

preload_app true #process loads the application, before the produce workflows.

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)


# before_exec do |server| 
#   ENV["BUNDLE_GEMFILE"] = "#{rails_root}/Gemfile"
# end

# before_fork do |server, worker|
#   defined?(ActiveRecord::Base) and  
#     ActiveRecord::Base.connection.disconect!  

#     if  File.exists?(old_pid) && server.pid != old_pid
#       begin
#         Process.kill("QUIT", File.read(old_pid).to_i)
#       rescue Errno::ENOENT, Errno::ESRCH
#     end
#   end
# end

# after_fork do |server, worker|
#   defined?(ActiveRecord::Base) and
#   ActiveRecord::Base.establish_connection
# end 

# base_path = "/Users/oleg/Documents/unicorn_nginx"

# working_directory base_path

# pid "#{base_path}/tmp/pids/unicorn.pid"

# stderr_path "#{base_path}/tmp/log/unicorn_error.log"
# stdout_path "#{base_path}/tmp/log/unicorn.log"

# listen "/tmp/unicorn.yp.sock"

# worker_processes  4
# timeout 30

