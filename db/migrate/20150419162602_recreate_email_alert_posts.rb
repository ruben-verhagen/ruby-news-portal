class RecreateEmailAlertPosts < ActiveRecord::Migration
  def up
    remove_column :email_alerts_posts, :headline
    remove_column :email_alerts_posts, :description

    add_column :email_alerts_posts, :headline, :string
    add_column :email_alerts_posts, :description, :text
  end
end
