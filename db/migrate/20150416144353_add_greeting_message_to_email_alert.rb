class AddGreetingMessageToEmailAlert < ActiveRecord::Migration
  def change
    add_column :email_alerts, :greeting_message, :text, default: ''
  end
end
