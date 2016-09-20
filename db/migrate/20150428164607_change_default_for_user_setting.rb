class ChangeDefaultForUserSetting < ActiveRecord::Migration
  def change
    change_column_default :user_settings, :email_alerts, :true
  end
end
