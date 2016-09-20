# Load DSL and Setup Up Stages
require 'capistrano/setup'

# Includes default deployment tasks
require 'capistrano/deploy'

require 'capistrano/rbenv'
require 'capistrano/bundler'
require 'capistrano/rails'
require 'capistrano/rails/assets'
require 'capistrano/rails/migrations'

require 'capistrano/puma'
require 'capistrano/puma/nginx'
# require 'whenever/capistrano'
# require 'airbrake/capistrano3'
# require 'new_relic/recipes'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }