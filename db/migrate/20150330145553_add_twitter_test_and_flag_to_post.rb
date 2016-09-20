class AddTwitterTestAndFlagToPost < ActiveRecord::Migration
  def change
    add_column :posts, :twitter_text, :text
    add_column :posts, :post_to_twitter, :boolean, default: false
  end
end
