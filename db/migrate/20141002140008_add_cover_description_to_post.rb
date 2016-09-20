class AddCoverDescriptionToPost < ActiveRecord::Migration
  def change
    add_column :posts, :cover_description, :text
  end
end
