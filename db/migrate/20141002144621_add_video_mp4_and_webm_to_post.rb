class AddVideoMp4AndWebmToPost < ActiveRecord::Migration
  def change
    add_column :posts, :video_mp4, :string
    add_column :posts, :video_webm, :string
  end
end