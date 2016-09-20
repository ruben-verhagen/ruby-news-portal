class AddSeoSiteSettings < ActiveRecord::Migration
  def up
    SiteSetting.create([
        { code: 'title', name: 'Default page title' },
        { code: 'meta_keywords', name: 'Meta keywords' },
        { code: 'meta_description', name: 'Meta description' }
    ])
  end
end
