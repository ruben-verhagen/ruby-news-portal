class AddUsersToMailgun < ActiveRecord::Migration
  def up
    service = MailgunService.new
    User.all.each do |user|
      if user.valid?
        begin
          service.create_member user, user.user_group
          puts "User with email #{user.email} added successfully to mailgun list"
        rescue StandardError => e
          puts "#{l(Time.zone.now, format: :default)}: User with email #{user.email} was not added to mailgun list #{user.user_group}. Message: #{e.message}"
        end
      end
    end
  end
end
