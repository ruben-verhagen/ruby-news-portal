class AddStatusToPdfEmailAlert < ActiveRecord::Migration
  def change
    add_column :pdf_email_alerts, :status, :string
  end
end
