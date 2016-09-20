class RecteatePostCoverMainSection < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      if post.cover.path
        post.cover.recreate_versions!(:main)
      end
    end
  end
end
