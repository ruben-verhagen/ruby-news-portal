class AddPostsCountToEmailAlertSchedule < ActiveRecord::Migration
  def change
    add_column :email_alert_schedules, :posts_count, :integer
  end
end
