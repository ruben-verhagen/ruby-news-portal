class AddUserGroupChangedAt < ActiveRecord::Migration
  def change
    add_column :users, :user_group_changed_at, :datetime, default: Time.zone.now
  end
end
