class RenameColumnsInUserSetting < ActiveRecord::Migration
  def change
    rename_column :user_settings, :email_enabled, :email_alerts
    remove_column :user_settings, :twitter_enabled, :boolean

    add_index :user_settings, :user_id
  end
end
