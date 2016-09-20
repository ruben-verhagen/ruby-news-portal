class AddListsToMailgun < ActiveRecord::Migration
  def up
    service = MailgunService.new
    User.user_groups.keys.each do |list|
      begin
        puts service.create_list(list)
      rescue Mailgun::Error => e
        puts "#{e.message} for List: #{list}"
      end
    end
  end

  def down
  end
end