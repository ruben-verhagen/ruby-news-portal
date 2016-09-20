class CreateLandingPages < ActiveRecord::Migration
  def change
    create_table :landing_pages do |t|
      t.string :title
      t.string :subdomain
      t.string :slug

      t.text :meta_description

      t.text :left_column_content
      t.text :center_column_content
      t.text :right_column_content

      t.timestamps
    end
  end
end
