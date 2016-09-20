class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :first_name
      t.string :last_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :zip
      t.string :email

      t.timestamps
    end
  end
end
