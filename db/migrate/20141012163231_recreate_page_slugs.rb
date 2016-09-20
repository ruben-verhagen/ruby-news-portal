class RecreatePageSlugs < ActiveRecord::Migration
  def up
    Page.all.each { |p| p.save }
  end
end
