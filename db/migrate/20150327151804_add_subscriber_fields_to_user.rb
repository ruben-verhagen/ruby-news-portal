class AddSubscriberFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :title, :string
    add_column :users, :company, :string
    add_column :users, :phone_number, :string
  end
end
