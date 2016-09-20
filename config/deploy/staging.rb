set :branch, 'master'
set :rails_env, 'staging'
set :unicorn_env, 'staging'

server '5.9.82.70', user: 'demo', roles: %w[app web db]