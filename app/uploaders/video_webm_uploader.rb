class VideoWebmUploader < BaseUploader
  def extension_white_list
    %w(webm)
  end
end
