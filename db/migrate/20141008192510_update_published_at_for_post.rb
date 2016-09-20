class UpdatePublishedAtForPost < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      post.update_attribute(:published_at, post.created_at)
    end
  end
end
