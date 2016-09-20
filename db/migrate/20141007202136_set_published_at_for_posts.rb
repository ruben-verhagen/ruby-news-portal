class SetPublishedAtForPosts < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      post.published_at = post.created_at
      post.save
    end
  end
end
