class DeviseCreateAdminUsers < ActiveRecord::Migration
  def change
    create_table(:admin_users) do |t|
      t.string :username
      t.string :email

      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      t.timestamps
    end

    add_index :admin_users, :username, unique: true
  end
end
