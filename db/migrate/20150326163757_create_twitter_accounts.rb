class CreateTwitterAccounts < ActiveRecord::Migration
  def change
    create_table :twitter_accounts do |t|
      t.string :access_token
      t.string :username
      t.string :access_token_secret
      t.string :uid
      t.string :url

      t.timestamps
    end
  end
end
