namespace :setup do
  desc 'Run a task on a remote server'
  task :invoke do
    on roles :all do
      execute("cd #{deploy_to}/current; bundle exec rake #{ENV['task']} RAILS_ENV=#{fetch(:rails_env)}")
    end
  end
end