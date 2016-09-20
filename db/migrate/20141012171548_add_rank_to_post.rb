class AddRankToPost < ActiveRecord::Migration
  def change
    add_column :posts, :rank, :integer
    add_column :posts, :rank_position, :integer
  end
end
