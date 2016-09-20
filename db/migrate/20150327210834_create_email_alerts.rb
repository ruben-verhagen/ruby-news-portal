class CreateEmailAlerts < ActiveRecord::Migration
  def change
    create_table :email_alerts do |t|
      t.text :user_groups
      t.text :post_ids
      t.string :status, default: 'in queue'

      t.timestamps
    end
  end
end
