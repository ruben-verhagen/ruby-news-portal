class UpdateRanksForPosts < ActiveRecord::Migration
  def up
    Post.latest.each_with_index { |post, index| post.update_attribute :rank_position, index }
  end
end
