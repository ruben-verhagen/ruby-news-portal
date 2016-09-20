class AddSubjectToEmailAlert < ActiveRecord::Migration
  def change
    add_column :email_alerts, :subject, :string
  end
end
