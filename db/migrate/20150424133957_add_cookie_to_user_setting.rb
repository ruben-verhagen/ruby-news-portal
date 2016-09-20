class AddCookieToUserSetting < ActiveRecord::Migration
  def change
    add_column :user_settings, :cookie, :boolean, default: true
  end
end
