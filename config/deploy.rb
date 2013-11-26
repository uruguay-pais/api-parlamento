#require 'rvm/capistrano'

set :rvm_ruby_string, '1.9.3'
set :rvmp_type, :user

#require 'bundler/capistrano'

# Set in stage unless it was setup in production
set :stage, 'staging' unless exists? :stage

# Get configuration
configuration = YAML.load_file('config/deploy.yml')[stage]

set :rails_env, configuration["rails_env"]

set :domain, "api.parlamento.datauy.org"
set :application, "api_parlamento"

set :deploy_to, configuration['deploy_to']
set :deploy_via, :remote_cache

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

set :user, configuration['user']
set :use_sudo, false

set :scm, :git
set :repository, configuration['repository']
set :branch, configuration['branch']


ssh_options[:keys] = ["/Users/gaba/.ssh/id_rsa"]

# set :git_shallow_clone, 1  # <<<----------MIRAR ESTA CONFIGURACION

server configuration['server'], :app, :web, :db, :primary => true

namespace :deploy do
  task :start do
    run "cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "if [ -f #{unicorn_pid} ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end

  desc 'Link configuration after a code update'
  task :symlink_configuration do
    links = {
      "#{release_path}/config.yaml" => "#{shared_path}/config.yaml"
    }
    #"ln -sf <a> <b>" creates a symbolic link but deletes <b> if it already exists
    run links.map {|a| "ln -sf #{a.last} #{a.first}"}.join(";")
  end

   #after "deploy:update_code", "deploy:symlink_configuration"
end
