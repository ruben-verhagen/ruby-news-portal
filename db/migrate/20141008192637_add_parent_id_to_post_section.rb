class AddParentIdToPostSection < ActiveRecord::Migration
  def change
    add_column :post_sections, :parent_id, :integer
    add_column :post_sections, :in_top_menu, :boolean, default: false

    add_index :post_sections, :parent_id
  end
end
