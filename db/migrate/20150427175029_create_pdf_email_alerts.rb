class CreatePdfEmailAlerts < ActiveRecord::Migration
  def change
    create_table :pdf_email_alerts do |t|
      t.string :file
      t.string :user_groups
      t.string :greeting_message

      t.timestamps
    end
  end
end
