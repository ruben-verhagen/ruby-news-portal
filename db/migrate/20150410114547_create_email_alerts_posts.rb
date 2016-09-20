class CreateEmailAlertsPosts < ActiveRecord::Migration
  def change
    create_table :email_alerts_posts do |t|
      t.integer :email_alert_id
      t.integer :post_id
      t.string :description

      t.timestamps
    end
  end
end
