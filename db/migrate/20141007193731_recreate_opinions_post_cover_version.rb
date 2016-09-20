class RecreateOpinionsPostCoverVersion < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      if post.cover.path
        post.cover.recreate_versions!(:opinions)
      end
    end
  end
end
