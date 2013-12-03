deploy_to = "/home/ubuntu/unicorn_nginx" # dir for deploy
rails_root = "#{deploy_to}/current" 
pid_file = "#{deploy_to}/shared/pids/unicorn.pid" # Sve pid
socket_file = "#{deploy_to}/shared/unicorn.sock" # Save sockets
log_file = "#{rails_root}/log/unicorn.log" # Save log
err_log = "#{rails_root}/log/unicorn_error.log" #Save error log
old_pid = pid_file + '.oldbin' #Save old pid 

timeout 30
worker_processes 4 # You can change it depending on the load
listen socket_file, :backlog => 1024
pid pid_file
stderr_path err_log
stdout_path log_file

preload_app true #process loads the application, before the produce workflows.

GC.copy_on_write_friendly = true if GC.respond_to?(:copy_on_write_friendly=)


before_exec do |server| 
  ENV["BUNDLE_GEMFILE"] = "#{rails_root}/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and  
    ActiveRecord::Base.connection.disconect!  

    if  File.exists?(old_pid) && server.pid != old_pid
      begin
        Process.kill("QUIT", File.read(old_pid).to_i)
      rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
  ActiveRecord::Base.establish_connection
end 

