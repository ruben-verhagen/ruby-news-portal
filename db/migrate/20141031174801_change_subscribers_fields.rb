class ChangeSubscribersFields < ActiveRecord::Migration
  def up
    remove_column :subscribers, :address_1
    remove_column :subscribers, :address_2
    remove_column :subscribers, :city
    remove_column :subscribers, :zip

    add_column :subscribers, :title, :string
    add_column :subscribers, :company, :string
    add_column :subscribers, :phone_number, :string
  end
end
