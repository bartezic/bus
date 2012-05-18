require "bundler/capistrano"

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
set :rvm_ruby_string, '1.9.3@bus' 
require "rvm/capistrano"  
set :rvm_type, :user

# before 'deploy:setup', 'rvm:install_rvm'
# before 'deploy:setup', 'rvm:install_ruby'

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
# load "config/recipes/rbenv"
load "config/recipes/check"

server "91.234.32.79", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "bus"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:bartezic/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy:assets:precompile", "deploy:restart_workers"
after "deploy:restart_workers", "deploy:restart_scheduler"

def run_remote_rake(rake_cmd)
  rake_args = ENV['RAKE_ARGS'].to_s.split(',')
  cmd = "cd #{fetch(:latest_release)} && #{fetch(:rake, "rake")} RAILS_ENV=#{fetch(:rails_env, "production")} #{rake_cmd}"
  cmd += "['#{rake_args.join("','")}']" unless rake_args.empty?
  run cmd
  set :rakefile, nil if exists?(:rakefile)
end

namespace :deploy do
  desc "Restart Resque Workers"
  task :restart_workers, :roles => :db do
    run_remote_rake "resque:restart_workers"
  end

  desc "Restart Resque scheduler"
  task :restart_scheduler, :roles => :db do
     run_remote_rake "resque:restart_scheduler"
  end
end

after "deploy", "deploy:cleanup" # keep only the last 5 releases