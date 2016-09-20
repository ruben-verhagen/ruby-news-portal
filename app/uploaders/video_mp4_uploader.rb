class VideoMp4Uploader < BaseUploader
  def extension_white_list
    %w(mp4)
  end
end
