class AddCoverToPostSection < ActiveRecord::Migration
  def change
    add_column :post_sections, :cover, :string
  end
end
