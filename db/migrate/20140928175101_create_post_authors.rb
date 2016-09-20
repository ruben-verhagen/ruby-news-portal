class CreatePostAuthors < ActiveRecord::Migration
  def change
    create_table :authors_posts do |t|
      t.integer :post_id
      t.integer :author_id
      t.timestamps
    end

    add_index :authors_posts, :post_id
    add_index :authors_posts, :author_id
  end
end
