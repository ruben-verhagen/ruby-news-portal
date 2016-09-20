class AddAlertAtToEmailAlert < ActiveRecord::Migration
  def change
    add_column :email_alerts, :alert_at, :datetime
  end
end
