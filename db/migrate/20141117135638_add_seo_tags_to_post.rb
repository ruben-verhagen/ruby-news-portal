class AddSeoTagsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :seo_title, :string
    add_column :posts, :seo_keywords, :string
    add_column :posts, :seo_description, :text
  end
end
