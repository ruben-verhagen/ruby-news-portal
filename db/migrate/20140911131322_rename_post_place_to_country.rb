class RenamePostPlaceToCountry < ActiveRecord::Migration
  def up
    remove_column :posts, :place
    add_column :posts, :country, :integer

    add_index :posts, :country
  end
end
