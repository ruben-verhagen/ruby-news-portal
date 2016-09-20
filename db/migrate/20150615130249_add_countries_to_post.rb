class AddCountriesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :countries, :text
  end
end
