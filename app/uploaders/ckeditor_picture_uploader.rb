class CkeditorPictureUploader < BaseUploader
  include CarrierWave::MiniMagick

  #process :read_dimensions

  version :thumb do
    process :resize_to_fill => [118, 100]
  end

  version :content do
    process :resize_to_fit => [968, 800]
  end

  def extension_white_list
    Ckeditor.image_file_types
  end
end
