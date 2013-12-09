rails_root = "/var/www/unicorn_nginx/current"#{deploy_to}/current" 

working_directory rails_root

pid "#{rails_root}/tmp/pids/unicorn.pid" # Save pid


socket_file = "#{rails_root}/tmp/sockets/unicorn.sock" # Save sockets
stdout_path "#{rails_root}/tmp/log/unicorn.stdout.log" # Save log
stderr_path rails_root+"/tmp/log/unicorn.stderr.log" #Save error log

timeout 30
worker_processes 1 # You can change it depending on the load
# listen socket_file, :backlog => 1024
listen socket_file


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


