class AddIsBreakingNewsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :is_breaking_news, :boolean, default: true
  end
end
