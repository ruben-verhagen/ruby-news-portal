class ImageUploader < BaseUploader
  def extension_white_list
    %w(jpg jpeg png gif)
  end

  def convert_to_grayscale
    manipulate! do |img|
      img.colorspace("Gray")
      img.brightness_contrast("-30x0")
      img = yield(img) if block_given?
      img
    end
  end
end