class ChangePdfEmailAlertGreetingMessageType < ActiveRecord::Migration
  def change
    change_column :pdf_email_alerts, :greeting_message, :text
  end
end
