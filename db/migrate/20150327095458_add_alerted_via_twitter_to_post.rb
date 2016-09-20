class AddAlertedViaTwitterToPost < ActiveRecord::Migration
  def change
    add_column :posts, :alerted_via_twitter, :boolean, default: false
  end
end
