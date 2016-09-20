class AddIsTopLedeToPost < ActiveRecord::Migration
  def change
    add_column :posts, :top_lede, :boolean, default: false
  end
end
