class CreateEmailAlertSchedules < ActiveRecord::Migration
  def change
    create_table :email_alert_schedules do |t|
      t.text :user_groups
      t.datetime :send_at
      t.integer :day_of_week
      t.text :greeting_message

      t.timestamps
    end
  end
end
