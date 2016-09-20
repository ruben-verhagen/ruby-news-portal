class CreatePostSections < ActiveRecord::Migration
  def change
    create_table :post_sections do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
