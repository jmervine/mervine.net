set :application, 'www.rubyops.net'
set :repository, "https://github.com/rubyops/www.rubyops.net.git"

# Set :user if you want to connect (via ssh) to your server using a
# different username. You will also need to include the user in :domain
# (see below).
#
#set :user, "deploy"
#set :domain, "#{user}@example.com"

set :deploy_to, "~/#{application}"


task :home do
  set :domain, "home.mervine.net"
end

task :live do
  set :domain, "www.rubyops.net"
end

# ============================================================================
# You probably don't need to worry about anything beneath this point...
# ============================================================================

require "tempfile"
require "vlad"

namespace :vlad do
  remote_task :symlink_attachments do
    run "ln -s #{shared_path}/content/attachments #{current_path}/public/attachments"
  end

  # overide vlad, which isn't working right
  remote_task :update_symlinks do
    run [ "ln -s #{shared_path}/log #{current_path}/log" ].join(" && ")
  end
  
  task :update do
    Rake::Task["vlad:symlink_attachments"].invoke
  end

  remote_task :bundle do
    run "cd #{current_path} && sudo bundle install --path ./vendor/bundle --without development test deploy"
  end
  
  # Depending on how you host Nesta, you might want to swap :start_app
  # with :start below. The :start_app task will tell your application
  # server (e.g. Passenger) to restart once your new code is deployed by
  # :update. Passenger is the default app server; tell Vlad that you're
  # using a different app server in the call to Vlad.load in Rakefile.
  #
  desc "Deploy the code and restart the server"
  task :deploy => [:update, :start_app]

  # If you use bundler to manage the installation of gems on your server
  # you can use this definition of the deploy task instead:
  #
   task :deploy => [:update, :bundle, :start_app]
end
