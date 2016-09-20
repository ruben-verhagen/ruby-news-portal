class TransferSectionsToPostsPostSections < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      section = PostSection.find(post.section_id) if post.section_id
      if section
        post.post_sections << section
      end
    end
  end
end
