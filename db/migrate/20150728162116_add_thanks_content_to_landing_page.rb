class AddThanksContentToLandingPage < ActiveRecord::Migration
  def change
    add_column :landing_pages, :thanks_content, :text
  end
end
