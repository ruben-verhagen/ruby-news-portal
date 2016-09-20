class RemoveEmailAlertSchedulesPost < ActiveRecord::Migration
  def change
    drop_table :email_alert_schedules_posts
  end
end
