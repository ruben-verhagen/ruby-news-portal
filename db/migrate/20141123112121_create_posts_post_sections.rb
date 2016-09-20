class CreatePostsPostSections < ActiveRecord::Migration
  def change
    create_table :post_sections_posts do |t|
      t.integer :post_id
      t.integer :post_section_id

      t.timestamps
    end

    add_index :post_sections_posts, :post_id
    add_index :post_sections_posts, :post_section_id
  end
end
