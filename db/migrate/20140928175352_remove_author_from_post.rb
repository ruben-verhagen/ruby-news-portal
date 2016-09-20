class RemoveAuthorFromPost < ActiveRecord::Migration
  def up
    remove_column :posts, :author_id
  end

  def down
    add_column :posts, :author_id, :integer
    add_index :posts, :author_id
  end
end
