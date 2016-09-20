class AddDefaultGreetingMessageSetting < ActiveRecord::Migration
  def up
    SiteSetting.create({ code: 'greeting_message', name: 'Default greeting message for email alerts' })
  end
end
