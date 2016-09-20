class TransferPostsToJoinTableForEmailAlert < ActiveRecord::Migration
  def up
    EmailAlert.all.each do |email_alert|
      email_alert.post_ids.each do |post_id|
        EmailAlertsPost.create(post_id: post_id, email_alert_id: email_alert.id)
      end

    end

    remove_column :email_alerts, :post_ids, :text
  end

  def down
    add_column :email_alerts, :post_ids, :text
  end
end
