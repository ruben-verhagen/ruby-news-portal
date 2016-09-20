class AddSignupAtUser < ActiveRecord::Migration
  def change
    add_column :users, :sign_up_at, :datetime
  end
end
