class AddVisibilityToPost < ActiveRecord::Migration
  def change
    add_column :posts, :visibility, :string, default: 'green'
  end
end
