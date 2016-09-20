class AddFlagsToPost < ActiveRecord::Migration
  def change
    add_column :posts, :featured_level, :integer
    add_column :posts, :in_digest, :boolean, default: false
  end
end
