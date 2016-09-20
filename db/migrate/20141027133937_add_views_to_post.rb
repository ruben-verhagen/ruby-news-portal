class AddViewsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :views, :integer, default: 0
  end
end
