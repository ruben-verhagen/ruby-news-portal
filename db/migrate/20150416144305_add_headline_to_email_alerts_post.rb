class AddHeadlineToEmailAlertsPost < ActiveRecord::Migration
  def change
    add_column :email_alerts_posts, :headline, :text
  end
end