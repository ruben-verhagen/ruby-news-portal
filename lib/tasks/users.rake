namespace :users do
  task :update_from_sso => :environment do
    processor = SSOUsersProcessor.new
    processor.expire_excluded
    processor.update_user_groups
  end
end