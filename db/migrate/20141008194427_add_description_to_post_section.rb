class AddDescriptionToPostSection < ActiveRecord::Migration
  def change
    add_column :post_sections, :description, :text
  end
end
