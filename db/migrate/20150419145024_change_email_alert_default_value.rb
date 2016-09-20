class ChangeEmailAlertDefaultValue < ActiveRecord::Migration
  def up
    change_column :email_alerts, :status, :string, default: 'initial'
  end
end
