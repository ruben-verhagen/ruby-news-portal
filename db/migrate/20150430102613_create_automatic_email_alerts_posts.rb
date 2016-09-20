class CreateAutomaticEmailAlertsPosts < ActiveRecord::Migration
  def change
    create_table :automatic_email_alerts_posts do |t|
      t.integer :automatic_email_alert_id
      t.integer :post_id

      t.timestamps
    end
  end
end
