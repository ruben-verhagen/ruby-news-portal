class AddTestUserGroupToMailgun < SeedMigration::Migration
  def up
    service = MailgunService.new
    puts service.create_list(:test)
  rescue Mailgun::Error => e
    puts "#{e.message} for List: #{:test}"
  end
end