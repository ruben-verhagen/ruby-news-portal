namespace :app do
  desc 'Start application'
  task :start do
    invoke 'puma:start'
  end

  desc 'Stop application'
  task :stop do
    invoke 'puma:stop'
  end

  desc 'Restart application'
  task :restart do
    invoke 'puma:restart'
  end
end