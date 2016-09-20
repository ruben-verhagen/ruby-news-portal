class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
      t.string :name
      t.string :slug
      t.text    :description
      t.string :code
      t.float :spread_min
      t.float :spread_max
      t.float :existing

      t.float :median_3
      t.float :median_6
      t.float :median_9
      t.float :median_12

      t.float :average_3
      t.float :average_6
      t.float :average_9
      t.float :average_12

      t.float :high_3
      t.float :high_6
      t.float :high_9
      t.float :high_12

      t.float :low_3
      t.float :low_6
      t.float :low_9
      t.float :low_12

      t.timestamps
    end

    add_index :graphs, :slug
  end
end
