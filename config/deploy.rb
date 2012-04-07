# RVM

$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.3-p125'
set :rvm_type, :user

# Bundler

require "bundler/capistrano"

# General

set :application, "bus"
set :user, "bus"

set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache

set :use_sudo, false

# Git

set :scm, :git
set :repository,  "git@github.com:bartezic/#{application}.git"
set :branch, "master"

# VPS

role :web, "91.234.32.79"
role :app, "91.234.32.79"
role :db,  "91.234.32.79", :primary => true
role :db,  "91.234.32.79"

# Passenger

namespace :deploy do
 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end