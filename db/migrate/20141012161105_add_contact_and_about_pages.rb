class AddContactAndAboutPages < ActiveRecord::Migration
  def up
    Page.create(title: 'Contact', code: 'contact')
    Page.create(title: 'About Us', code: 'about_us')
  end
end
