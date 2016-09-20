class SetDefaultSignUpCountForUser < ActiveRecord::Migration
  def up
    change_column :users, :sign_up_count, :integer, default: 0
  end
end
