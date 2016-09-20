class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :section_id
      t.integer :author_id
      t.string :cover
      t.string :slug

      t.string :place
      t.string :headline
      t.text :byline
      t.text :content

      t.boolean :authors_pick, default: false
      t.boolean :published, dafault: true

      t.timestamps
    end

    add_index :posts, :section_id
    add_index :posts, :author_id
    add_index :posts, :slug
  end
end
