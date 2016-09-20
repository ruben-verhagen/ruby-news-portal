class RemovePostCountFromEmailAlertSchedule < ActiveRecord::Migration
  def up
    remove_column :email_alert_schedules, :posts_count
  end
end
