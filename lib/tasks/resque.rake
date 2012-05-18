require 'resque/tasks'
require 'resque_scheduler/tasks'

def run_worker
  puts "Starting worker *"
  ops = {:pgroup => true, :err => [(Rails.root + "log/workers_error.log").to_s, "a"], 
                          :out => [(Rails.root + "log/workers.log").to_s, "a"]}
  env_vars = {"QUEUE" => "*"}
  pid = spawn(env_vars, "rake resque:work", ops)
  Process.detach(pid)
end

def run_scheduler
  puts "Starting resque scheduler"
  env_vars = {
    "BACKGROUND" => "1",
    "PIDFILE" => (Rails.root + "tmp/pids/resque_scheduler.pid").to_s,
    "VERBOSE" => "1"
  }
  ops = {:pgroup => true, :err => [(Rails.root + "log/scheduler_error.log").to_s, "a"],
                          :out => [(Rails.root + "log/scheduler.log").to_s, "a"]}
  pid = spawn(env_vars, "rake resque:scheduler", ops)
  Process.detach(pid)
end

namespace :resque do
  task :setup => :environment do
    Resque.before_fork = Proc.new { ActiveRecord::Base.establish_connection }
  end

  desc "Restart running workers"
  task :restart_workers => :environment do
    pids = Resque.workers.map {|w| w.to_s.split(/:/).second }
    system("kill -QUIT #{pids.join(' ')}") if pids.any?
    run_worker
  end
  
  desc "Restart scheduler"
  task :restart_scheduler => :environment do
    pidfile = Rails.root + "tmp/pids/resque_scheduler.pid"
    if File.exists?(pidfile)
      system("kill -QUIT #{File.read(pidfile).to_i}")
      FileUtils.rm_f(pidfile)
    end
    run_scheduler
  end
end
