class RecreatePhotoCoverPdfVersion < ActiveRecord::Migration
  def up
    Post.all.each do |post|
      if post.cover.path
        post.cover.recreate_versions!(:pdf)
      end
    end
  end
end
