class AddToAutomationEmailFlagToPost < ActiveRecord::Migration
  def change
    add_column :posts, :in_automatic_email, :boolean, default: false
  end
end
