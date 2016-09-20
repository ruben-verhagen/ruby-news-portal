# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'mni_euro_insight'
set :rails_env, :staging
set :repo_url, 'git@gitlab.risearrow.com:root/mni.git'

set :deploy_to, "/home/demo/apps/#{fetch(:application)}/#{fetch(:rails_env)}"

set :linked_files, %w{config/database.yml config/secrets.yml}
set :linked_dirs, %w{log tmp/pids public/assets tmp/cache tmp/sockets vendor/bundle public/system }

set :unicorn_config_path, "#{release_path}/config/unicorn.rb"

set :keep_releases, 5
set :ssh_options, { forward_agent: true }

set :rbenv_ruby, '2.1.5'

task :seed_data do
  on roles :all do
    within release_path do
      with rails_env: fetch(:rails_env) do
        execute :rake, "seed:migrate"
      end
    end
  end
end

after 'deploy:publishing', 'app:restart'
after 'deploy:finished', 'seed_data'

