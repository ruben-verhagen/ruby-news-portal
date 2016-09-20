class AddPreviousUserGroupToUser < ActiveRecord::Migration
  def change
    add_column :users, :previous_user_group, :string
  end
end
