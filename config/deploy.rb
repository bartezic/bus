require "bundler/capistrano"

set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

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

# default_run_options[:pty] = true
# ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases