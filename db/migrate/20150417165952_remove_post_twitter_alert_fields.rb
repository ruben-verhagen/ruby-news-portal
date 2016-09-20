class RemovePostTwitterAlertFields < ActiveRecord::Migration
  def up
    remove_column :posts, :alerted_via_twitter
    remove_column :posts, :twitter_text
    remove_column :posts, :post_to_twitter
  end
end
