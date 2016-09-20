class AddSignupCountToUser < ActiveRecord::Migration
  def change
    add_column :users, :sign_up_count, :integer, default: 1
  end
end