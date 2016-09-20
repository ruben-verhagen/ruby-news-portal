class AddBoolFieldsToSalesManager < ActiveRecord::Migration
  def change
    add_column :sales_managers, :email_registrants, :boolean, default: 'true'
    add_column :sales_managers, :trial_registrants, :boolean, default: 'true'
  end
end
