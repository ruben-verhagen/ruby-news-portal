class AddNamesToGraphsSections < ActiveRecord::Migration

  def change
    add_column :graphs, :period_3_name, :string
    add_column :graphs, :period_6_name, :string
    add_column :graphs, :period_9_name, :string
    add_column :graphs, :period_12_name, :string
  end
end
