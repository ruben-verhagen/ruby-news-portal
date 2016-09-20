namespace :app do
  desc 'Prepare app after code base update'
  task :prepare => :environment do
    logger = Logger.new('log/app_prepare.log')
    ['assets:precompile', 'db:migrate', 'seed:migrate'].each do |task|
      logger.info "Running #{task} post install command"
      begin
        Rake::Task[task].invoke

        logger.info "#{task} was successfully completed"
      rescue StandardError => e
        logger.error "#{task} failed due the next error: #{e.message}"
      end
    end
  end
end
