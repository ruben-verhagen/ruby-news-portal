class ChangePostCountryType < ActiveRecord::Migration
  def up
    remove_column :posts, :country
    add_column :posts, :country, :string
  end
end
