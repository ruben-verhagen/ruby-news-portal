namespace :seed_section do


  desc 'Requiring faker and rails env'
  task :seed_env => :environment do
    require File.expand_path('lib/fake_helper', Rails.root)

    def run_seed(seed_file)
      require Rails.root.join('db/seeds',  seed_file.to_s + '.rb')
      puts "#{seed_file.capitalize} seeds were successfully loaded"
    end
  end

  desc 'Common seeds'
  task :common => :seed_env do
    run_seed(:common)
  end

end
