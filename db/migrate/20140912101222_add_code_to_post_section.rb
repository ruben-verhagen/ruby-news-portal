class AddCodeToPostSection < ActiveRecord::Migration
  def change
    add_column :post_sections, :code, :string
    add_index :post_sections, :code
  end
end
