

require "bundler/capistrano"
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

server "91.234.32.79", :web, :app, :db, primary: true

set :rvm_ruby_string, '1.9.3@bus'
set :rvm_type, :user
set :rvm_install_type, :head


set :application, "bus"
set :user, "bus"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:bartezic/#{application}.git"
set :branch, "master"

namespace :deploy do
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end

before 'deploy:assets:precompile', 'deploy:symlink_db'

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

namespace :god do
  def god_is_running
    !capture("#{god_command} status >/dev/null 2>/dev/null || echo 'not running'").start_with?('not running')
  end

  def god_command
    "cd #{current_path}; bundle exec god"
  end

  desc "Stop god"
  task :terminate_if_running do
    if god_is_running
      run "#{god_command} terminate"
    end
  end

  desc "Start god"
  task :start do
    config_file = "#{current_path}/config/resque.god"
    environment = { :RAILS_ENV => rails_env, :RAILS_ROOT => current_path }
    run "#{god_command} -c #{config_file}", :env => environment
  end
end

before "deploy:update", "god:terminate_if_running"
after "deploy:update", "god:start"

after "deploy", "deploy:cleanup"
after "deploy:migrations", "deploy:cleanup"