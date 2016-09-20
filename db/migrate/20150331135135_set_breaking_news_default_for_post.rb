class SetBreakingNewsDefaultForPost < ActiveRecord::Migration
  def up
    change_column :posts, :is_breaking_news, :boolean, default: false
  end

  def down
    change_column :posts, :is_breaking_news, :boolean, default: true
  end
end
