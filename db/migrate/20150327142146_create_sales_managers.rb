class CreateSalesManagers < ActiveRecord::Migration
  def change
    create_table :sales_managers do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end
