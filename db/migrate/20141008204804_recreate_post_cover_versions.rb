class RecreatePostCoverVersions < ActiveRecord::Migration
  def up
    PostSection.all.each do |section|
      if section.cover.path
        section.cover.recreate_versions!(:thumb_small)
      end
    end
  end
end
