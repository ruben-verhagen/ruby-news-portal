class ChangeDaysOfWeekToEmailAlertSchedule < ActiveRecord::Migration
  def change
    remove_column :email_alert_schedules, :day_of_week
    add_column :email_alert_schedules, :days_of_week, :string
  end
end
