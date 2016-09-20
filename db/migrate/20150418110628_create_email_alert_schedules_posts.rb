class CreateEmailAlertSchedulesPosts < ActiveRecord::Migration
  def change
    create_table :email_alert_schedules_posts do |t|
      t.integer :email_alert_schedule_id
      t.integer :post_id

      t.timestamps
    end
  end
end
