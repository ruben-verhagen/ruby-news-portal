class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :place
      t.text :description
      t.datetime :happens_at

      t.timestamps
    end
  end
end
