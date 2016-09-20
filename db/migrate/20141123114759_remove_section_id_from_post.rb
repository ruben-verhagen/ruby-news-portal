class RemoveSectionIdFromPost < ActiveRecord::Migration
  def up
    remove_column :posts, :section_id
  end

  def down
    add_column :posts, :section_id, :integer
    add_index :posts, :section_id
  end
end
