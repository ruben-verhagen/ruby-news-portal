class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.boolean :email_enabled, default: false
      t.boolean :twitter_enabled, default: false
      t.references :user
      t.timestamps
    end
  end
end
