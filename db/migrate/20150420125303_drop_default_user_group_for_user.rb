class DropDefaultUserGroupForUser < ActiveRecord::Migration
  def up
    change_column :users, :user_group, :string, default: nil
  end
end
