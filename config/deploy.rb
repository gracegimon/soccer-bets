set :application, 'tupote'
set :repository,  'git@github.com:gracegimon/soccer-bets.git'
set :deploy_to, "/home/mikehonik/webapps/tupote"


set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "web388.webfaction.com"                          # Your HTTP server, Apache/etc
role :app, "web388.webfaction.com"                          # This may be the same as your `Web` server
role :db,  "web388.webfaction.com", :primary => true # This is where Rails migrations will run

set :user, "mikehonik"
set :scm_username, "gracegimon"
set :use_sudo, false
default_run_options[:pty] = true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
set :ssh_options, { :forward_agent => true }
set :branch, "master"

namespace :deploy do
  desc "Restart nginx"
  task :restart do
    run "#{deploy_to}/bin/restart"
  end
end