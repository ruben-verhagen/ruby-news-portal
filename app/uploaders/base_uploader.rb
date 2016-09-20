class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def cache_dir
    @cache_dir ||= Rails.root.join 'tmp/uploads'
  end

  def store_dir
    "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id / 100}/#{model.id}"
  end
end
