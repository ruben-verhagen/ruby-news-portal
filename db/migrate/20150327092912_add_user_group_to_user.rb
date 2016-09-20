class AddUserGroupToUser < ActiveRecord::Migration
  def change
    add_column :users, :user_group, :string
  end
end
