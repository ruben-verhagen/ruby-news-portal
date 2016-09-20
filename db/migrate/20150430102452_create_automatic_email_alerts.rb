class CreateAutomaticEmailAlerts < ActiveRecord::Migration
  def change
    create_table :automatic_email_alerts do |t|
      t.integer :email_alert_schedule_id


      t.timestamps
    end
  end
end
